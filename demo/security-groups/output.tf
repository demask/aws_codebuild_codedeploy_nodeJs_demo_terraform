output "job1_sg" {
  value = aws_security_group.job1_sg.id
}

output "job1_lb_sg" {
  value = aws_security_group.job1_lb_sg.id
}
