terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }

  backend "s3" {
    bucket = "terraform-remote-state-prepzee"
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

module "my_s3_bucket" {
  source            = "../../tf_modules/s3_bucket/"  # Path to the module
  bucket_name       = "sit-prepzee-12345"
  acl               = "private"
  force_destroy     = true
  enable_versioning = true
  tags = {
    Environment = "Sit"
    Project     = "S3Demo"
  }
}

output "bucket_outputs" {
  value = module.my_s3_bucket
}

