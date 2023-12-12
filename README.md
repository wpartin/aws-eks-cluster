## Usage

```hcl
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

module "eks_cluster" {
  source = "../.."

  enabled       = module.eks_cluster_label.enabled
  # enable_openid = true
  name          = module.eks_cluster_label.id_full
  # subnet_ids    = ["subnet-01234567890abcdef"]

  tags = module.eks_cluster_label.tags
}

output "eks_cluster" {
  value = module.eks_cluster.this
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.amazon_eks_cluster_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_eks_vpc_resource_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role_openid](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnets.these](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_timeouts"></a> [cluster\_timeouts](#input\_cluster\_timeouts) | An object containing any desired timeout configurations. | <pre>object({<br>    create = string<br>    delete = string<br>    update = string<br>  })</pre> | <pre>{<br>  "create": null,<br>  "delete": null,<br>  "update": null<br>}</pre> | no |
| <a name="input_enable_openid"></a> [enable\_openid](#input\_enable\_openid) | Enable or disable openid configuration for IAM roles. | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Enable or disable the module. | `bool` | n/a | yes |
| <a name="input_endpoint_private_access"></a> [endpoint\_private\_access](#input\_endpoint\_private\_access) | Enable private endpoint access. | `bool` | `true` | no |
| <a name="input_endpoint_public_access"></a> [endpoint\_public\_access](#input\_endpoint\_public\_access) | Enable public endpoint access. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the cluster resources. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region in which to deploy. | `string` | `"us-east-1"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | How long to keep the logs in CloudWatch. | `number` | `7` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | The role ARN to associate with the cluster resources. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet ids to associate the cluster resources with. | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of key/value tags to apply to the resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the EKS cluster. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint for the EKS cluster. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the EKS cluster. |
| <a name="output_name"></a> [name](#output\_name) | The name of the EKS cluster. |
| <a name="output_platform_version"></a> [platform\_version](#output\_platform\_version) | The platform version of the EKS cluster. |
| <a name="output_public_access_cidrs"></a> [public\_access\_cidrs](#output\_public\_access\_cidrs) | The public access CIDR blocks if enabled. |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The role ARN being used on the EKS cluster. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The security group ID associated with the EKS cluster. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | The subnet IDs associated with the EKS cluster. |
| <a name="output_version"></a> [version](#output\_version) | The version of the EKS cluster. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID that the EKS cluster is associated with. |
<!-- END_TF_DOCS -->
