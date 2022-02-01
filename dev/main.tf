resource "aws_ecs_task_definition" "test" {
  family                   = "test"
  task_role_arn            = var.task_role
  execution_role_arn       = var.task_role
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions    = <<TASK_DEFINITION
[
  {
   "logConfiguration": {
      "logDriver": "awslogs",
      "secretOptions": null,
      "options": {
        "awslogs-group": "/ecs/standardjob-task",
        "awslogs-region": "eu-central-1",
        "awslogs-stream-prefix": "ecs"
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
    "image": "246005639140.dkr.ecr.eu-central-1.amazonaws.com/standardjob:jenkins-test",
    "name": "standardjob"
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
  }
}