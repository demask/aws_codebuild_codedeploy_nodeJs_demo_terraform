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
  
  dynamic "load_balancer" {
    for_each = var.lb_target_groups
    content {
    	target_group_arn = load_balancer.value.target_group_arn
  		container_name = load_balancer.value.container_name
  		container_port = load_balancer.value.container_port
    }
  }

  dynamic "service_registries" {
    for_each = var.service_registries
    content {
      registry_arn = service_registries.value.registry_arn
    }
  }
}
