locals {
  enabled         = var.enabled ? toset([var.name]) : toset([])
  openid_disabled = var.enabled && !var.enable_openid ? toset([var.name]) : toset([])
  openid_enabled  = var.enabled && var.enable_openid ? toset([var.name]) : toset([])
  role_arn        = var.enabled ? coalesce(var.role_arn, aws_iam_role.this[var.name].arn) : null
  subnet_ids      = var.enabled ? coalesce(var.subnet_ids, data.aws_subnets.these.ids) : null
}