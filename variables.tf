variable "cluster_timeouts" {
  description = "An object containing any desired timeout configurations."
  type = object({
    create = string
    delete = string
    update = string 
  })
  default = {
    create = null
    delete = null
    update = null
  }
}

variable "enabled" {
  description = "Enable or disable the module."
  type        = bool
}

variable "enable_openid" {
  description = "Enable or disable openid configuration for IAM roles."
  type        = bool
  default     = false
}

variable "endpoint_private_access" {
  description = "Enable private endpoint access."
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public endpoint access."
  type        = bool
  default     = false
}

variable "name" {
  description = "The name of the cluster resources."
  type        = string
}

variable "region" {
  description = "The region in which to deploy."
  type        = string
  default     = "us-east-1"

  validation {
    condition     = contains(["us-east-1", "us-east-2", "us-west-1", "us-west-2"], var.region)
    error_message = "Must be one of the following regions: us-east-1, us-east-2, us-west-1, us-west-2"
  }
}

variable "retention_in_days" {
  description = "How long to keep the logs in CloudWatch."
  type        = number
  default     = 7
}

variable "role_arn" {
  description = "The role ARN to associate with the cluster resources."
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A list of subnet ids to associate the cluster resources with."
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "A map of key/value tags to apply to the resources."
  type        = map(string)
}