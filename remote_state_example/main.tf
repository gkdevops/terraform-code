provider "aws" {
  version = "3.4.0"
  profile = "default"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "intellipaat-s3-bucket-demo"
    key    = "development/demo/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Terraform_Sample"
  }
}
