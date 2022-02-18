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
  default = true
}

variable "subnets" {
  description = "ECS service public subnets"
  type        = list(string)
  default = ["subnet-03a64430c69f5fd34", "subnet-0a47d243cdad92853", "subnet-0a47d243cdad92853"]
}

variable "security_groups" {
  description = "ECS service security groups"
  type        = list(string)
  default = ["sg-0180ca3dc1db6662f"]
}