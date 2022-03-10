output "job1_service_discovery_service_arn" {
  value = aws_service_discovery_service.job1_discovery_service.arn
}

output "job2_service_discovery_service_arn" {
  value = aws_service_discovery_service.job2_discovery_service.arn
}

output "job3_service_discovery_service_arn" {
  value = aws_service_discovery_service.job3_discovery_service.arn
}

output "other_repo_job_discovery_service_arn" {
  value = aws_service_discovery_service.other_repo_job_discovery_service.arn
}