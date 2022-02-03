provider_region = "eu-central-1"
aws_account_id = "246005639140"
task_definition_role = "arn:aws:iam::246005639140:role/ecsTaskExecutionRole"
task_definition_name = "job3"
requires_compatibilities = ["FARGATE"]
cpu = 256
memory = 512
container_cpu = 0
port_mappings = [
      {
        "hostPort": 8080,
        "protocol": "tcp",
        "containerPort": 8080
      }
    ]
environment_variables = null
docker_image_name = "job3"
