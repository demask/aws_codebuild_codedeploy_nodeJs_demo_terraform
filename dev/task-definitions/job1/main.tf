module "task_definition" {
  source = "../../../modules/task-definition"

  task_definition_role = "arn:aws:iam::246005639140:role/ecsTaskExecutionRole"
  task_definition_name = "job1"
  requires_compatibilities = ["FARGATE"]
  cpu = 256
  memory = 512

  container_definitions = [
  {
   "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/job1",
        "awslogs-region": "eu-central-1",
        "awslogs-stream-prefix": "ecs",
        "awslogs-create-group": "true"
      }
    },
    "portMappings": [
      {
        "hostPort": 3000,
        "protocol": "tcp",
        "containerPort": 3000
      }
    ],
    "cpu": 0,
    "environment": null,
    "image": "246005639140.dkr.ecr.eu-central-1.amazonaws.com/job1:${var.docker_image_tag}",
    "name": "job1"
  }
]
}

module "service" {
  source = "../../../modules/ecs-service"

  name            = "job1"
  cluster         = "DEV"
  task_definition = module.task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  platform_version = "LATEST"
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent = 200

  network_configuration {
    assign_public_ip = true
    subnets = var.subnets
    security_groups = var.security_groups
  }
}
