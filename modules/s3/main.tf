resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_acl" "this" {
  count  = var.bucket_acl == "NULL" ? 0 : 1
  bucket = aws_s3_bucket.this.id
  acl    = var.bucket_acl
}

module "s3_objects" {
  source  = "./objects"
  bucket  = aws_s3_bucket.this.bucket
  objects = var.objects
}