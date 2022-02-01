terraform {
    backend "s3" {
      bucket         = "terraform-demo-bucket-state-2022"
      key            = "dev/terraform.tfstate"
      region         = "eu-central-1"
  
      dynamodb_table = "terraform-demo-locks"
      encrypt        = true
    }
  }
  
  provider "aws" {
    region = var.provider_region
  }