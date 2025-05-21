terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }
  backend "s3" {
    bucket  = "valaxy-terraform-state"
    key     = "dev/sales/terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# define a variable
variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "myname" {
  default = "Goutham"
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

data "aws_s3_bucket" "mybucket" {
  bucket = "valaxy-terraform-state"
}

# Print the value of the variables
output "aws_availability_zones" {
  value = data.aws_availability_zones.listofzones
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "print_s3_details" {
  value = data.aws_s3_bucket.mybucket
}

output "name_details" {
  value = var.myname
}
