terraform {
    backend "s3" {
      bucket         = "terraform-demo-bucket-state-2022"
      key            = "demo/terraform_job1.tfstate"
      region         = "eu-central-1"
  
      dynamodb_table = "terraform-demo-locks"
      encrypt        = true
    }
  }
  
  provider "aws" {
    region = "eu-central-1"
  }