resource "aws_service_discovery_private_dns_namespace" "service_discovery_namespace" {
  name        = "dev"
  description = "Dev discovery namespace"
  vpc         = "vpc-0c940bac15452202c"
}
