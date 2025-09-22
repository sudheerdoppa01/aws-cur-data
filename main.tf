module "cur_s3_bucket" {
  source      = "./modules/cur_s3_bucket"
  environment = var.environment
  region      = var.region
}