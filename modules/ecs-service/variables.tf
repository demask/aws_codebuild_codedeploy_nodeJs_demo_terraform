variable "name" {
  description = "ECS service name"
  type        = string
}

variable "cluster" {
  description = "ECS cluster ARN name"
  type        = string
}

variable "task_definition" {
  description = "ECS service task definition ARN"
  type        = string
}

variable "desired_count" {
  description = "ECS service desired count"
  type        = number
}

variable "launch_type" {
  description = "ECS service launch type"
  type        = string
}

variable "platform_version" {
  description = "ECS service platform version"
  type        = string
}

variable "deployment_minimum_healthy_percent" {
  description = "ECS service deployment minimum"
  type        = number
}

variable "deployment_maximum_percent" {
  description = "ECS service deployment maximum"
  type        = number
}