terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }

  backend "s3" {
    bucket  = "terraform-remote-state-prepzee"
    key     = "dev/sales/terraform.tfstate"
    region  = "us-east-1"
    profile = "development"
  }

}

# Configure the AWS Provider
provider "aws" {
  profile = "development"
  region  = "us-east-1"
}

module "my_s3_bucket" {
  source            = "../../tf_modules/s3_bucket/" # Path to the module
  bucket_name       = var.bucket_name
  acl               = var.acl
  force_destroy     = var.force_destroy
  enable_versioning = var.enable_versioning
  tags              = var.tags
}

output "bucket_outputs" {
  value = module.my_s3_bucket
}

