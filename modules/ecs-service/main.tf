resource "aws_ecs_service" "service" {
  name            = var.name
  cluster         = var.cluster
  task_definition = var.task_definition
  desired_count   = var.desired_count
  launch_type     = var.launch_type
  platform_version = var.platform_version
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent = var.deployment_maximum_percent

  network_configuration {
    assign_public_ip = var.assign_public_ip
    subnets = var.subnets
    security_groups = var.security_groups
  }
  
  service_registries {
  	registry_arn = var.registry_arn
  }
}
