resource "aws_s3_bucket" "cur_data" {
  bucket        = "aws-cur-data-${var.environment}"
  force_destroy = true

  tags = {
    Name        = "AWS CUR Data Bucket"
    Environment = var.environment
    Owner       = "sudheer"
  }
}

resource "aws_s3_bucket_public_access_block" "cur_data_block" {
  bucket = aws_s3_bucket.cur_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "cur_data_versioning" {
  bucket = aws_s3_bucket.cur_data.id

  versioning_configuration {
    status = "Enabled"
  }
}
