resource "aws_s3_bucket" "bog-terraform-state" {
  bucket = "${var.bucket_name}" 
}

resource "aws_s3_bucket_acl" "bog-terraform-state_bucket_acl" {
  bucket = aws_s3_bucket.bog-terraform-state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_bog-terraform-state" {
  bucket = aws_s3_bucket.bog-terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
 bucket = aws_s3_bucket.bog-terraform-state.id

 block_public_acls       = true
 block_public_policy     = true
 ignore_public_acls      = true
 restrict_public_buckets = true
}

