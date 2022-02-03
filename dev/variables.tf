variable "state_bucket_name" {
  description = "State bucket name"
  type        = string
  default     = "terraform-demo-bucket-state-2022"
}

variable "state_bucket_key" {
  description = "State bucket key"
  type        = string
  default     = "dev/s3/terraform.tfstate"
}

variable "state_locks_name" {
  description = "State locks name"
  type        = string
  default     = "terraform-demo-locks"
}