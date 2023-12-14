## Usage

```hcl
/* context labels */

module "this" {
  source = "git::github.com/wpartin/terraform-context?ref=v0.1.0"

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

/* eks cluster */

module "eks_cluster" {
  source = "git::github.com/wpartin/terraform-context?ref=v0.1.0"

  enabled = module.eks_cluster_label.enabled
  name    = module.eks_cluster_label.id_full

  tags = module.eks_cluster_label.tags
}

output "eks_cluster" {
  value = module.eks_cluster.this
}
```

```sh
/* The examples/basic configuration will result in the following type of plan output: */

Terraform will perform the following actions:

  # module.eks_cluster.aws_cloudwatch_log_group.this["sandbox-use1-eks-grasshopper-fabled-cottonfield"] will be created
  + resource "aws_cloudwatch_log_group" "this" {
      + arn               = (known after apply)
      + id                = (known after apply)
      + log_group_class   = "STANDARD"
      + name              = "/aws/eks/sandbox-use1-eks-grasshopper-fabled-cottonfield/cluster"
      + name_prefix       = (known after apply)
      + retention_in_days = 7
      + skip_destroy      = false
      + tags              = {
          + "Account"     = "Development"
          + "Cost-Center" = "Engineering"
          + "Domain"      = "Containers"
          + "Environment" = "Sandbox"
          + "Project"     = "Goldenrod"
        }
      + tags_all          = {
          + "Account"     = "Development"
          + "Cost-Center" = "Engineering"
          + "Domain"      = "Containers"
          + "Environment" = "Sandbox"
          + "Project"     = "Goldenrod"
        }
    }

  # module.eks_cluster.aws_eks_cluster.this["sandbox-use1-eks-grasshopper-fabled-cottonfield"] will be created
  + resource "aws_eks_cluster" "this" {
      + arn                   = (known after apply)
      + certificate_authority = (known after apply)
      + cluster_id            = (known after apply)
      + created_at            = (known after apply)
      + endpoint              = (known after apply)
      + id                    = (known after apply)
      + identity              = (known after apply)
      + name                  = "sandbox-use1-eks-grasshopper-fabled-cottonfield"
      + platform_version      = (known after apply)
      + role_arn              = (known after apply)
      + status                = (known after apply)
      + tags                  = {
          + "Account"     = "Development"
          + "Cost-Center" = "Engineering"
          + "Domain"      = "Containers"
          + "Environment" = "Sandbox"
          + "Project"     = "Goldenrod"
        }
      + tags_all              = {
          + "Account"     = "Development"
          + "Cost-Center" = "Engineering"
          + "Domain"      = "Containers"
          + "Environment" = "Sandbox"
          + "Project"     = "Goldenrod"
        }
      + version               = (known after apply)

      + encryption_config {
          + resources = [
              + "secrets",
            ]

          + provider {
              + key_arn = (known after apply)
            }
        }

      + timeouts {}

      + vpc_config {
          + cluster_security_group_id = (known after apply)
          + endpoint_private_access   = true
          + endpoint_public_access    = false
          + public_access_cidrs       = (known after apply)
          + subnet_ids                = [
              + "subnet-12345678",
              + "subnet-abcdefgh",
              + "subnet-abc123de",
            ]
          + vpc_id                    = (known after apply)
        }
    }

  # module.eks_cluster.aws_iam_role.this["sandbox-use1-eks-grasshopper-fabled-cottonfield"] will be created
  + resource "aws_iam_role" "this" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "eks.amazonaws.com"
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "sandbox-use1-eks-grasshopper-fabled-cottonfield"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags                  = {
          + "Account"     = "Development"
          + "Cost-Center" = "Engineering"
          + "Domain"      = "Containers"
          + "Environment" = "Sandbox"
          + "Project"     = "Goldenrod"
        }
      + tags_all              = {
          + "Account"     = "Development"
          + "Cost-Center" = "Engineering"
          + "Domain"      = "Containers"
          + "Environment" = "Sandbox"
          + "Project"     = "Goldenrod"
        }
      + unique_id             = (known after apply)
    }

  # module.eks_cluster.aws_iam_role_policy_attachment.amazon_eks_cluster_policy["sandbox-use1-eks-grasshopper-fabled-cottonfield"] will be created
  + resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
      + role       = "sandbox-use1-eks-grasshopper-fabled-cottonfield"
    }

  # module.eks_cluster.aws_iam_role_policy_attachment.amazon_eks_vpc_resource_controller["sandbox-use1-eks-grasshopper-fabled-cottonfield"] will be created
  + resource "aws_iam_role_policy_attachment" "amazon_eks_vpc_resource_controller" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
      + role       = "sandbox-use1-eks-grasshopper-fabled-cottonfield"
    }

  # module.eks_cluster.module.kms.aws_kms_key.this["enabled"] will be created
  + resource "aws_kms_key" "this" {
      + arn                                = (known after apply)
      + bypass_policy_lockout_safety_check = false
      + customer_master_key_spec           = "SYMMETRIC_DEFAULT"
      + deletion_window_in_days            = 30
      + description                        = "test EKS cluster"
      + enable_key_rotation                = false
      + id                                 = (known after apply)
      + is_enabled                         = true
      + key_id                             = (known after apply)
      + key_usage                          = "ENCRYPT_DECRYPT"
      + multi_region                       = (known after apply)
      + policy                             = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "kms:*"
                      + Effect    = "Allow"
                      + Principal = {
                          + AWS = "0123456789012"
                        }
                      + Resource  = "*"
                      + Sid       = "enable-IAM-user-permissions"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + tags                               = {
          + "Account"     = "Development"
          + "Cost-Center" = "Engineering"
          + "Domain"      = "Containers"
          + "Environment" = "Sandbox"
          + "Project"     = "Goldenrod"
        }
      + tags_all                           = {
          + "Account"     = "Development"
          + "Cost-Center" = "Engineering"
          + "Domain"      = "Containers"
          + "Environment" = "Sandbox"
          + "Project"     = "Goldenrod"
        }
    }

Plan: 6 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + eks_cluster = {
      + arn                 = (known after apply)
      + endpoint            = (known after apply)
      + id                  = (known after apply)
      + kms_key_arn         = (known after apply)
      + name                = "sandbox-use1-eks-grasshopper-fabled-cottonfield"
      + platform_version    = (known after apply)
      + public_access_cidrs = null
      + role_arn            = (known after apply)
      + security_group_id   = (known after apply)
      + subnet_ids          = [
          + "subnet-12345678",
          + "subnet-abcdefgh",
          + "subnet-abc123de",
        ]
      + version             = (known after apply)
      + vpc_id              = (known after apply)
    }
```

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a     |
| <a name="provider_tls"></a> [tls](#provider_tls) | n/a     |

## Modules

| Name                                         | Source                          | Version |
| -------------------------------------------- | ------------------------------- | ------- |
| <a name="module_kms"></a> [kms](#module_kms) | git::github.com/wpartin/aws-kms | v0.1.0  |

## Resources

| Name                                                                                                                                                                        | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)                                           | resource    |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)                                                             | resource    |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider)                             | resource    |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                   | resource    |
| [aws_iam_role_policy_attachment.amazon_eks_cluster_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)          | resource    |
| [aws_iam_role_policy_attachment.amazon_eks_vpc_resource_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource    |
| [aws_iam_policy_document.assume_role_openid](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                            | data source |
| [aws_iam_policy_document.assume_role_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                           | data source |
| [aws_subnets.these](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets)                                                                 | data source |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate)                                                          | data source |

## Inputs

| Name                                                                                                      | Description                                                                             | Type                                                                                                                  | Default                                                                      | Required |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | :------: |
| <a name="input_cluster_timeouts"></a> [cluster_timeouts](#input_cluster_timeouts)                         | An object containing any desired timeout configurations.                                | <pre>object({<br> create = string<br> delete = string<br> update = string<br> })</pre>                                | <pre>{<br> "create": null,<br> "delete": null,<br> "update": null<br>}</pre> |    no    |
| <a name="input_create_kms_key"></a> [create_kms_key](#input_create_kms_key)                               | Use KMS to generate a new KMS key for this cluster's encryption configuration.          | `bool`                                                                                                                | `true`                                                                       |    no    |
| <a name="input_description"></a> [description](#input_description)                                        | A description for the resources associated with this EKS cluster.                       | `string`                                                                                                              | n/a                                                                          |   yes    |
| <a name="input_enable_encryption"></a> [enable_encryption](#input_enable_encryption)                      | Enable or disable cluster encryption.                                                   | `bool`                                                                                                                | `true`                                                                       |    no    |
| <a name="input_enable_openid"></a> [enable_openid](#input_enable_openid)                                  | Enable or disable openid configuration for IAM roles.                                   | `bool`                                                                                                                | `false`                                                                      |    no    |
| <a name="input_enabled"></a> [enabled](#input_enabled)                                                    | Enable or disable the module.                                                           | `bool`                                                                                                                | n/a                                                                          |   yes    |
| <a name="input_encryption_configuration"></a> [encryption_configuration](#input_encryption_configuration) | An object containing the configuration information for the cluster encryption settings. | <pre>object({<br> provider = optional(object({<br> key_arn = string<br> }))<br> resources = list(string)<br> })</pre> | <pre>{<br> "resources": [<br> "secrets"<br> ]<br>}</pre>                     |    no    |
| <a name="input_endpoint_private_access"></a> [endpoint_private_access](#input_endpoint_private_access)    | Enable private endpoint access.                                                         | `bool`                                                                                                                | `true`                                                                       |    no    |
| <a name="input_endpoint_public_access"></a> [endpoint_public_access](#input_endpoint_public_access)       | Enable public endpoint access.                                                          | `bool`                                                                                                                | `false`                                                                      |    no    |
| <a name="input_name"></a> [name](#input_name)                                                             | The name of the cluster resources.                                                      | `string`                                                                                                              | n/a                                                                          |   yes    |
| <a name="input_region"></a> [region](#input_region)                                                       | The region in which to deploy.                                                          | `string`                                                                                                              | `"us-east-1"`                                                                |    no    |
| <a name="input_retention_in_days"></a> [retention_in_days](#input_retention_in_days)                      | How long to keep the logs in CloudWatch.                                                | `number`                                                                                                              | `7`                                                                          |    no    |
| <a name="input_role_arn"></a> [role_arn](#input_role_arn)                                                 | The role ARN to associate with the cluster resources.                                   | `string`                                                                                                              | `null`                                                                       |    no    |
| <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids)                                           | A list of subnet ids to associate the cluster resources with.                           | `list(string)`                                                                                                        | `null`                                                                       |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                             | A map of key/value tags to apply to the resources.                                      | `map(string)`                                                                                                         | n/a                                                                          |   yes    |

## Outputs

| Name                                                                                         | Description                                            |
| -------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| <a name="output_arn"></a> [arn](#output_arn)                                                 | The ARN of the EKS cluster.                            |
| <a name="output_endpoint"></a> [endpoint](#output_endpoint)                                  | The endpoint for the EKS cluster.                      |
| <a name="output_id"></a> [id](#output_id)                                                    | The ID of the EKS cluster.                             |
| <a name="output_kms_key_arn"></a> [kms_key_arn](#output_kms_key_arn)                         | The KMS key ARN if created from this module usage.     |
| <a name="output_name"></a> [name](#output_name)                                              | The name of the EKS cluster.                           |
| <a name="output_platform_version"></a> [platform_version](#output_platform_version)          | The platform version of the EKS cluster.               |
| <a name="output_public_access_cidrs"></a> [public_access_cidrs](#output_public_access_cidrs) | The public access CIDR blocks if enabled.              |
| <a name="output_role_arn"></a> [role_arn](#output_role_arn)                                  | The role ARN being used on the EKS cluster.            |
| <a name="output_security_group_id"></a> [security_group_id](#output_security_group_id)       | The security group ID associated with the EKS cluster. |
| <a name="output_subnet_ids"></a> [subnet_ids](#output_subnet_ids)                            | The subnet IDs associated with the EKS cluster.        |
| <a name="output_version"></a> [version](#output_version)                                     | The version of the EKS cluster.                        |
| <a name="output_vpc_id"></a> [vpc_id](#output_vpc_id)                                        | The VPC ID that the EKS cluster is associated with.    |

<!-- END_TF_DOCS -->
