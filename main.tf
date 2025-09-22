module "cur_s3_bucket" {
  source      = "./modules/cur_s3_bucket"
  environment = var.environment
  region      = var.region
}

module "athena" {
  source               = "./modules/athena"
  environment          = var.environment
  database_name_prefix = "cur_db"
  bucket_name          = module.cur_s3_bucket.bucket_name
  region               = var.region
}