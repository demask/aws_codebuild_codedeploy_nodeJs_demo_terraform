variable "terraform_required_version" {
  description = "Minimum requried Terraform version"
  type        = string
  default     = ">= 0.15"
}

variable "provider_region" {
  description = "Provider region"
  type        = string
  default     = "eu-central-1"
}

variable "state_bucket_name" {
  description = "Terraform state bucket name"
  type        = string
  default     = "terraform-demo-bucket-state-2022"
}

variable "state_locks_name" {
  description = "Terraform state locks name"
  type        = string
  default     = "terraform-demo-locks"
}