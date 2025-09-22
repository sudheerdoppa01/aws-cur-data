output "cur_bucket_name" {
  value = module.cur_s3_bucket.bucket_name
}

output "athena_database" {
  value = module.athena.db_name
}
