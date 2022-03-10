resource "aws_service_discovery_private_dns_namespace" "service_discovery_namespace" {
  name        = "demo"
  description = "Demo discovery namespace"
  vpc         = "vpc-0c940bac15452202c"
}
