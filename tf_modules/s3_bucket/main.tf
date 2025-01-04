resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  acl           = var.acl
  force_destroy = var.force_destroy

  tags = var.tags

  versioning {
    enabled = var.enable_versioning
  }
}
