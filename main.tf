provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 1.5.0"
}

##########
# Locals #
##########

locals {
  enabled         = var.enabled ? toset([var.name]) : toset([])
  openid_disabled = var.enabled && !var.enable_openid ? toset([var.name]) : toset([])
  openid_enabled  = var.enabled && var.enable_openid ? toset([var.name]) : toset([])
  role_arn        = var.enabled ? coalesce(var.role_arn, aws_iam_role.this[var.name].arn) : null
  subnet_ids      = var.enabled ? coalesce(var.subnet_ids, data.aws_subnets.these.ids) : null
}

###########
# Imports #
###########

data "aws_subnets" "these" {
  filter {
    name   = "default-for-az"
    values = [true]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = [false]
  }
}

###################
# CloudWatch Logs #
###################

module "cloudwatch_logs" {
  source = "git::github.com/wpartin/terraform-aws-cloudwatch?ref=v0.1.0"

  description       = var.description
  enabled           = var.enabled
  name              = var.name
  retention_in_days = var.retention_in_days

  context = var.context

  tags = var.tags
}

#######
# KMS #
#######

module "kms" {
  source = "git::github.com/wpartin/terraform-aws-kms?ref=v0.1.1"

  enabled     = var.enabled && var.encryption_configuration.provider.key_arn == null
  description = var.description

  context = var.context

  tags = var.tags
}

###############
# EKS Cluster #
###############

resource "aws_eks_cluster" "this" {
  for_each = local.enabled

  enabled_cluster_log_types = var.cluster_log_types
  name                      = var.name
  role_arn                  = local.role_arn

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    subnet_ids              = local.subnet_ids
  }

  dynamic "encryption_config" {
    for_each = var.enable_encryption ? [var.encryption_configuration] : []

    content {
      provider {
        key_arn = var.create_kms_key ? module.kms.key_arn : encryption_config.value.key_arn
      }
      resources = encryption_config.value.resources
    }
  }

  tags = var.tags

  timeouts {
    create = lookup(var.cluster_timeouts, "create")
    delete = lookup(var.cluster_timeouts, "delete")
    update = lookup(var.cluster_timeouts, "update")
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy,
    aws_iam_role_policy_attachment.amazon_eks_vpc_resource_controller,
    module.cloudwatch_logs
  ]
}

data "aws_iam_policy_document" "assume_role_service" {
  for_each = local.openid_disabled

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  for_each = local.openid_disabled

  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role_service[var.name].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  for_each = local.openid_disabled

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.this[var.name].name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_vpc_resource_controller" {
  for_each = local.openid_disabled

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.this[var.name].name
}

##########
# OpenID #
##########

data "aws_iam_policy_document" "assume_role_openid" {
  for_each = local.openid_enabled

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.this[var.name].url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.this[var.name].arn]
      type        = "Federated"
    }
  }
}

data "tls_certificate" "this" {
  for_each = local.openid_enabled

  url = aws_eks_cluster.this[var.name].identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "this" {
  for_each = local.openid_enabled

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.this[var.name].certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.this[var.name].url

  tags = var.tags
}