module "task_definition" {
  source = "../modules/task-definition"

  provider_region = var.provider_region
  aws_account_id = var.aws_account_id
  task_definition_role = var.task_definition_role
  task_definition_name = var.task_definition_name
  requires_compatibilities = var.requires_compatibilities
  cpu = var.cpu
  memory = var.memory
  container_cpu = var.container_cpu
  port_mappings = var.port_mappings
  environment_variables = var.environment_variables
  docker_image_tag = var.docker_image_tag
  docker_image_name = var.docker_image_name
  container_definitions = [
  {
   "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${var.task_definition_name}",
        "awslogs-region": "${var.provider_region}",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "portMappings": var.port_mappings,
    "cpu": var.container_cpu,
    "environment": var.environment_variables,
    "image": "${var.aws_account_id}.dkr.ecr.${var.provider_region}.amazonaws.com/${var.docker_image_name}:${var.docker_image_tag}",
    "name": "${var.docker_image_name}"
  }
]
}