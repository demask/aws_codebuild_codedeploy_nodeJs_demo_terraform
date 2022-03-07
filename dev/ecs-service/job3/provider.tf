terraform {
    backend "s3" {
      bucket         = "terraform-demo-bucket-state-2022"
      key            = "dev/terraform_job3.tfstate"
      region         = "eu-central-1"
  
      dynamodb_table = "terraform-demo-locks"
      encrypt        = true
    }
  }
  
  provider "aws" {
    region = "eu-central-1"
  }