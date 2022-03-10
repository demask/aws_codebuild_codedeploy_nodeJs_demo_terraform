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
        key     = "demo/terraform_dev_sg.tfstate"
        region  = "eu-central-1"
    }
}

data "terraform_remote_state" "service_discovery_service" {
  backend = "s3"
  config = {
    bucket = "terraform-demo-bucket-state-2022"
    key    = "demo/terraform_discovery_service.tfstate"
    region = "eu-central-1"
  }
}

module "task_definition" {
  source = "../../../modules/task-definition"

  task_definition_role = "arn:aws:iam::246005639140:role/ecsTaskExecutionRole"
  task_definition_name = "other-repo-job-demo"
  requires_compatibilities = ["FARGATE"]
  cpu = 256
  memory = 512

  container_definitions = [
  {
   "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/other-repo-job-demo",
        "awslogs-region": "eu-central-1",
        "awslogs-stream-prefix": "ecs",
        "awslogs-create-group": "true"
      }
    },
    "portMappings": [
      {
        "hostPort": 8099,
        "protocol": "tcp",
        "containerPort": 8099
      }
    ],
    "cpu": 0,
    "environment": null,
    "image": "246005639140.dkr.ecr.eu-central-1.amazonaws.com/other-repo-job:${var.docker_image_tag}",
    "name": "other-repo-job"
  }
]
}

module "service" {
  source = "../../../modules/ecs-service"

  name            = "other-repo-job"
  cluster         = "DEMO"
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
  		registry_arn = data.terraform_remote_state.service_discovery_service.outputs.other_repo_job_discovery_service_arn
  	}
  ]

  lb_target_groups = []
}