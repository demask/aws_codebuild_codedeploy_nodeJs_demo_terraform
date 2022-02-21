data "terraform_remote_state" "service_discovery_namespace" {
    backend = "s3"
    config {
        bucket  = "terraform-demo-bucket-state-2022"
        key     = "dev/terraform_service_discovery_namespace.tfstate"
        region  = "eu-central-1"
    }
}

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

resource "aws_service_discovery_service" "job1_discovery_service" {
  name = "job1"

  dns_config {
    namespace_id = data.terraform_remote_state.service_discovery_namespace.discovery_namespace_id

    dns_records {
      ttl  = 100
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
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
  assign_public_ip = true
  subnets = ["subnet-03a64430c69f5fd34", "subnet-0a47d243cdad92853", "subnet-0a47d243cdad92853"]
  security_groups = ["sg-0180ca3dc1db6662f"]
}
