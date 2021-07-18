terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.46.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "foo" {
  ami           = "ami-0b0af3577fe5e3532"
  instance_type = "t2.micro"
  key_name = "aws"
  security_groups = ["default", "sg-026bfa6a295451cf2"]
}
