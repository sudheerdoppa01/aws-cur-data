output "bucket_name" {
  value = aws_s3_bucket.cur_data.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.cur_data.id
}