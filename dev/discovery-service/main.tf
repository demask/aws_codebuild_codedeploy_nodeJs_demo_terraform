data "terraform_remote_state" "service_discovery_namespace" {
  backend = "s3"
  config = {
    bucket = "terraform-demo-bucket-state-2022"
    key    = "dev/terraform_service_discovery_namespace.tfstate"
    region = "eu-central-1"
  }
}

resource "aws_service_discovery_service" "job1_discovery_service" {
  name = "job1"

  dns_config {
    namespace_id = data.terraform_remote_state.service_discovery_namespace.outputs.discovery_namespace_id

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

resource "aws_service_discovery_service" "job2_discovery_service" {
  name = "job2"

  dns_config {
    namespace_id = data.terraform_remote_state.service_discovery_namespace.outputs.discovery_namespace_id

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

resource "aws_service_discovery_service" "job3_discovery_service" {
  name = "job3"

  dns_config {
    namespace_id = data.terraform_remote_state.service_discovery_namespace.outputs.discovery_namespace_id

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
