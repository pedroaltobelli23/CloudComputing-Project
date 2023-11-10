terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">=4.47.0"
    }
  }

    #   backend "s3" {
    #     bucket = "backup-bucket"
    #     key = "my-terraform-project"
    #     region = "us-east-1"
    #   }
  
  required_version = "~> 1.0"
}