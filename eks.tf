resource "aws_eks_cluster" "this" {
  for_each = local.enabled

  name     = var.name
  role_arn = local.role_arn

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    subnet_ids              = local.subnet_ids
  }

  tags = var.tags

  timeouts {
    create = lookup(var.cluster_timeouts, "create")
    delete = lookup(var.cluster_timeouts, "delete")
    update = lookup(var.cluster_timeouts, "update")
  }

  depends_on = [aws_cloudwatch_log_group.this]
}