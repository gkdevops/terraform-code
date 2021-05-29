provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-remote-state-intellipaat"
    key    = "staging/demo-1/terraform.tfstate"
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
