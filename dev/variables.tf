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

variable "provider_region" {
  description = "Provider region"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account id"
  type        = string
}

variable "task_definition_role" {
  description = "ECS task execution role"
  type        = string
}

variable "task_definition_name" {
  description = "ECS task definition name"
  type        = string
}

variable "requires_compatibilities" {
  description = "ECS task requires compatibilities"
  type        = list(string)
}

variable "cpu" {
  description = "ECS task cpu"
  type        = number
}

variable "memory" {
  description = "ECS task memory"
  type        = number
}

variable "container_cpu" {
  description = "ECS task container cpu"
  type        = number
}

variable "port_mappings" {
  description = "ECS task container port mappings"
  type = list(object({
    hostPort = number
    containerPort = number
    protocol = string
  }))
}

variable "environment_variables" {
  description = "ECS task container environment variables"
  type = list(object({
    name = string
    value = string
  }))
}

variable "docker_image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "docker_image_name" {
  description = "Docker image name"
  type        = string
}

variable "container_definitions" {
  description = "Container definitions"
  type = list(object({
    logDriver = string
    options = object({
      awslogs-group = string
      awslogs-region = string
      awslogs-stream-prefix = string
    })
    portMappings = list(object({
      hostPort = number
      containerPort = number
      protocol = string
    }))
    cpu = number
    environment = list(object({
      name = string
      value = string
    }))
    image = string
    name = string
  }))
}