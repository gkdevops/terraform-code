terraform {
  backend "s3" {
    bucket = "terraform-remote-state-intellipaat"
    key    = "dev/network/terraform.tfstate"
    region = "us-east-1"
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
  default = "10.0.0.0/16"
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
data "aws_availability_zones" "available" {}

# Print the value of the variables
output "aws_availability_zones" {
  value = data.aws_availability_zones.available
}
