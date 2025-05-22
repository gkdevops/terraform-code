module "my_s3_bucket" {
  source            = "../../tf_modules/s3_bucket/"  # Path to the module
  bucket_name       = "sit-prepzee-12345"
  acl               = "private"
  force_destroy     = true
  enable_versioning = "Enabled"
  tags = {
    Environment = "Sit"
    Project     = "S3Demo"
  }
}


output "bucket_outputs" {
  value = module.my_s3_bucket
}

