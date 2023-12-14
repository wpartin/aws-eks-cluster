module "kms" {
  source = "git::github.com/wpartin/aws-kms?ref=v0.1.0"

  enabled     = var.enabled
  description = var.description

  tags = var.tags
}