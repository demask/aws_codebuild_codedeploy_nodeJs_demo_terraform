resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.task_definition_name
  task_role_arn            = var.task_definition_role
  execution_role_arn       = var.task_definition_role
  requires_compatibilities = var.requires_compatibilities
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = <<TASK_DEFINITION
[
  {
   "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${var.task_definition_name}",
        "awslogs-region": "${var.provider_region}",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "portMappings": ${var.port_mappings},
    "cpu": ${var.container_cpu},
    "environment": ${var.environment_variables},
    "image": "${var.aws_account_id}.dkr.ecr.${var.provider_region}.amazonaws.com/${var.docker_image_name}:${var.docker_image_tag}",
    "name": "${var.docker_image_name}"
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
  }
}