terraform {
    backend "s3" {
      bucket         = "terraform-demo-bucket-state-2022"
      key            = "demo/terraform_other-repo-job.tfstate"
      region         = "eu-central-1"
  
      dynamodb_table = "terraform-demo-locks"
      encrypt        = true
    }
  }
  
  provider "aws" {
    region = "eu-central-1"
  }