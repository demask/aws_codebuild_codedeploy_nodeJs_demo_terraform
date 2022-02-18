variable "docker_image_tag" {
  description = "Docker image tag"
  type        = string
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
  default = ["subnet-03a64430c69f5fd34", "subnet-0a47d243cdad92853", "subnet-0a47d243cdad92853"]
}
