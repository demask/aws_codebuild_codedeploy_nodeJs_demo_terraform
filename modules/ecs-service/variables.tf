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

variable "assign_public_ip" {
  description = "ECS service assign public ip"
  type        = bool
}

variable "subnets" {
  description = "ECS service public subnets"
  type        = list(string)
}

variable "security_groups" {
  description = "ECS service security groups"
  type        = list(string)
}

variable "registry_arn" {
  description = "ECS service registry arn"
  type        = string
}

variable "target_group_arn" {
  description = "ECS service load balancer target group arn"
  type        = string
}

variable "container_name" {
  description = "ECS service load balancer container name"
  type        = string
}

variable "container_port" {
  description = "ECS service load balancer container port"
  type        = number
}
