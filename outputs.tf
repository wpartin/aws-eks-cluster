output "arn" {
  description = "The ARN of the EKS cluster."
  value       = var.enabled ? aws_eks_cluster.this[var.name].arn : null
}

output "endpoint" {
  description = "The endpoint for the EKS cluster."
  value       = var.enabled ? aws_eks_cluster.this[var.name].endpoint : null
}

output "id" {
  description = "The ID of the EKS cluster."
  value       = var.enabled ? aws_eks_cluster.this[var.name].cluster_id : null
}

output "name" {
  description = "The name of the EKS cluster."
  value       = var.enabled ? aws_eks_cluster.this[var.name].name : null
}

output "platform_version" {
  description = "The platform version of the EKS cluster."
  value       = var.enabled ? aws_eks_cluster.this[var.name].platform_version : null
}

output "role_arn" {
  description = "The role ARN being used on the EKS cluster."
  value       = var.enabled ? aws_eks_cluster.this[var.name].role_arn : null
}

output "version" {
  description = "The version of the EKS cluster."
  value       = var.enabled ? aws_eks_cluster.this[var.name].version : null
}

output "security_group_id" {
  description = "The security group ID associated with the EKS cluster."
  value       = var.enabled ? aws_eks_cluster.this[var.name].vpc_config[0].cluster_security_group_id : null
}

output "public_access_cidrs" {
  description = "The public access CIDR blocks if enabled."
  value       = var.enabled && var.endpoint_public_access ? aws_eks_cluster.this[var.name].vpc_config[0].public_access_cidrs : null
}

output "subnet_ids" {
  description = "The subnet IDs associated with the EKS cluster."
  value       = var.enabled ? aws_eks_cluster.this[var.name].vpc_config[0].subnet_ids : null
}

output "vpc_id" {
  description = "The VPC ID that the EKS cluster is associated with."
  value       = var.enabled ? aws_eks_cluster.this[var.name].vpc_config[0].vpc_id : null
}