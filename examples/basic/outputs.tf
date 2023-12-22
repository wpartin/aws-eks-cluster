output "arn" {
  description = "The ARN of the EKS cluster."
  value       = module.eks_cluster.arn
}

output "endpoint" {
  description = "The endpoint for the EKS cluster."
  value       = module.eks_cluster.endpoint
}

output "id" {
  description = "The ID of the EKS cluster."
  value       = module.eks_cluster.id
}

output "name" {
  description = "The name of the EKS cluster."
  value       = module.eks_cluster.name
}

output "platform_version" {
  description = "The platform version of the EKS cluster."
  value       = module.eks_cluster.platform_version
}

output "public_access_cidrs" {
  description = "The public access CIDR ranges if configured."
  value       = module.eks_cluster.public_access_cidrs
}

output "role_arn" {
  description = "The role ARn being used on the EKS cluster."
  value       = module.eks_cluster.role_arn
}

output "security_group_id" {
  description = "The security group ID associated with the EKS cluster."
  value       = module.eks_cluster.security_group_id
}

output "subnet_ids" {
  description = "The subnet IDs associated with the EKS cluster."
  value       = module.eks_cluster.subnet_ids
}

output "version" {
  description = "The version of the EKS cluster."
  value       = module.eks_cluster.version
}

output "vpc_id" {
  description = "The VPC ID that the EKS cluster is associated with."
  value       = module.eks_cluster.vpc_id
}