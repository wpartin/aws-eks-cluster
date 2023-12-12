module "eks_cluster" {
  source = "../.."

  enabled = module.eks_cluster_label.enabled
  # enable_openid = true
  name = module.eks_cluster_label.id_full
  # subnet_ids    = ["subnet-01234567890abcdef"]

  tags = module.eks_cluster_label.tags
}

output "eks_cluster" {
  value = module.eks_cluster
}