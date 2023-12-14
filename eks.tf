resource "aws_eks_cluster" "this" {
  for_each = local.enabled

  name     = var.name
  role_arn = local.role_arn

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

  depends_on = [aws_cloudwatch_log_group.this]
}