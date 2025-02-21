terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }

  backend "s3" {
    bucket = "valaxy-terraform-state"
    key    = "sit/sales/terraform.tfstate"
    region = "us-east-1"
    profile = "development"
  }

}

# Configure the AWS Provider
provider "aws" {
  profile = "development"
  region  = "us-east-1"
}

