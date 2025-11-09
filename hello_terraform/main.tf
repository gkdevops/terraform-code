terraform {
  required_version = ">= 1.13.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.20"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "foo" {
  ami           = "ami-0157af9aea2eef346"
  instance_type = "t2.micro"
  key_name = "aws"
}
