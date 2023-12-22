module "eks_cluster" {
  source = "../.."

  description = "test EKS cluster"
  enabled     = module.eks_cluster_label.enabled
  # enable_openid = true
  name   = module.eks_cluster_label.id_full
  region = module.eks_cluster_label.region
  # subnet_ids    = ["subnet-01234567890abcdef"]

  context = module.eks_cluster_label.context

  tags = module.eks_cluster_label.tags
}