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

resource "aws_alb_target_group" "alb_target_group" {  
  name     = "job1-lb-tg-demo"
  port     = 80  
  protocol = "HTTP"  
  target_type = "ip"
  vpc_id   = "vpc-0c940bac15452202c"   
   
  lifecycle {
     create_before_destroy = true
  }
  
  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10    
    path                = "/"    
    port                = 3000 
  }
}

resource "aws_lb" "job1_lb" {
  name               = "job1-lb-demo"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.dev_security_group.outputs.job1_lb_sg]
  subnets            = data.aws_subnets.subnets.ids
}

resource "aws_alb_listener" "alb_listener" {  
  load_balancer_arn = aws_lb.job1_lb.arn  
  port              = 80  
  protocol          = "HTTP"
  
  default_action {    
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    type             = "forward"  
  }
}


