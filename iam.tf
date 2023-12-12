data "aws_iam_policy_document" "assume_role_service" {
  for_each = local.openid_disabled

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  for_each = local.openid_disabled

  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role_service[var.name].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  for_each = local.openid_disabled

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.this[var.name].name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_vpc_resource_controller" {
  for_each = local.openid_disabled

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.this[var.name].name
}