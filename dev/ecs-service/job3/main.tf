data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0c940bac15452202c"]
  }
}

data "terraform_remote_state" "dev_security_group" {
    backend = "s3"
    config = {
        bucket  = "terraform-demo-bucket-state-2022"
        key     = "dev/terraform_dev_sg.tfstate"
        region  = "eu-central-1"
    }
}

data "terraform_remote_state" "service_discovery_service" {
  backend = "s3"
  config = {
    bucket = "terraform-demo-bucket-state-2022"
    key    = "dev/terraform_discovery_service.tfstate"
    region = "eu-central-1"
  }
}

module "task_definition" {
  source = "../../../modules/task-definition"

  task_definition_role = "arn:aws:iam::246005639140:role/ecsTaskExecutionRole"
  task_definition_name = "job3"
  requires_compatibilities = ["FARGATE"]
  cpu = 256
  memory = 512

  container_definitions = [
  {
   "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/job3",
        "awslogs-region": "eu-central-1",
        "awslogs-stream-prefix": "ecs",
        "awslogs-create-group": "true"
      }
    },
    "portMappings": [
      {
        "hostPort": 8043,
        "protocol": "tcp",
        "containerPort": 8043
      }
    ],
    "cpu": 0,
    "environment": null,
    "image": "246005639140.dkr.ecr.eu-central-1.amazonaws.com/job3:${var.docker_image_tag}",
    "name": "job3"
  }
]
}

module "service" {
  source = "../../../modules/ecs-service"

  name            = "job3"
  cluster         = "DEV"
  task_definition = module.task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  platform_version = "LATEST"
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent = 200
  assign_public_ip = true
  subnets = data.aws_subnets.subnets.ids
  security_groups = [data.terraform_remote_state.dev_security_group.outputs.job1_sg]
  
  service_registries = [
  	{
  		registry_arn = data.terraform_remote_state.service_discovery_service.outputs.job3_service_discovery_service_arn
  	}
  ]

  lb_target_groups = []
}
