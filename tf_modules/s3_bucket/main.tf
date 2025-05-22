resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = var.tags

}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.enable_versioning
  }
}

resource "aws_s3_bucket_acl" "this" {

  bucket = aws_s3_bucket.this.id
  acl    = var.acl
}
