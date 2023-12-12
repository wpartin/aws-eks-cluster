data "aws_iam_policy_document" "assume_role_openid" {
  for_each = local.openid_enabled

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.this[var.name].url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.this[var.name].arn]
      type        = "Federated"
    }
  }
}

data "tls_certificate" "this" {
  for_each = local.openid_enabled

  url = aws_eks_cluster.this[var.name].identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "this" {
  for_each = local.openid_enabled

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.this[var.name].certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.this[var.name].url

  tags = var.tags
}