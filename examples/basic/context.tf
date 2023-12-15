module "this" {
  source = "git::github.com/wpartin/terraform-context?ref=v0.1.0"

  #   enabled   = false
  env       = "sandbox"
  namespace = "eks"

  tags = {
    Account     = "Development"
    Cost-Center = "Engineering"
    Domain      = "Containers"
    Environment = "Sandbox"
    Project     = "Goldenrod"
  }
}

module "eks_cluster_label" {
  source = "git::github.com/wpartin/terraform-context?ref=v0.1.0"

  id     = "grasshopper-fabled-cottonfield"
  region = "us-east-1"

  context = module.this.context
}
