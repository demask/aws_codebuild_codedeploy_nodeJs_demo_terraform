
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

variable "container_definitions" {
  description = "A list of container definitions"
  default     = []
}