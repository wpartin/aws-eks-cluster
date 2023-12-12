output "this" {
    value = var.enabled ? aws_eks_cluster.this[var.name] : null
}