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

module "this" {
  source = "../../tf_modules/complete-vpc-module"
  vpc_cidr = "10.2.0.0/16"
  public_cidrs = ["10.2.1.0/24", "10.2.2.0/24"]
  private_cidrs = ["10.2.4.0/24", "10.2.3.0/24"]  
  ingress_ports = [9090, 22]
}

output "bucket_outputs" {
  value = module.my_s3_bucket
}

