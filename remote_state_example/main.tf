terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }

  backend "s3" {
    bucket = "terraform-remote-state-prepzee"
    key    = "dev/networking/terraform.tfstate"
    region = "us-east-1"
    profile = "development"
  }

}

# Configure the AWS Provider
provider "aws" {
  profile = "development"
  region  = "us-east-1"
}

# define a variable
variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

# create a aws resource
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "Terraform_VPC"
  }
}

# Query all avilable Availibility Zone.
data "aws_availability_zones" "listofzones" {}

# Print the value of the variables
output "aws_availability_zones" {
  value = data.aws_availability_zones.listofzones
}

output "vpc_id" {
  value = aws_vpc.main.id
}
