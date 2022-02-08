resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.task_definition_name
  task_role_arn            = var.task_definition_role
  execution_role_arn       = var.task_definition_role
  requires_compatibilities = var.requires_compatibilities
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = jsonencode(var.container_definitions)

  runtime_platform {
    operating_system_family = "LINUX"
  }
}