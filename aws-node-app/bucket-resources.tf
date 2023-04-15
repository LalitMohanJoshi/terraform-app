resource "aws_s3_bucket" "aws-tf-bucket" {
  bucket = "aws-terraform-bucket-546546"
}

resource "aws_s3_bucket_public_access_block" "aws-tf-bucket" {
  bucket = aws_s3_bucket.aws-tf-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
