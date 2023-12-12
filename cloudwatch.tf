resource "aws_cloudwatch_log_group" "this" {
  for_each = local.enabled

  name              = "/aws/eks/${var.name}/cluster"
  retention_in_days = var.retention_in_days

  tags = var.tags
}