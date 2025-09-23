provider "aws" {
  region = var.region
}

module "s3" {
  source      = "./modules/s3-archive-bucket"
  bucket_name = "cost-usage-work-out"
}

module "sns" {
  source     = "./modules/sns-cost-alerts"
  topic_name = "cost-report-alerts"
}

module "athena" {
  source      = "./modules/athena-cur-catalog"
  db_name     = "cur_database"
  table_name  = "aws_cost_optimization_report_testing"
  s3_location = "s3://${module.s3.bucket_name}/cur/"
}

module "lambda" {
  source             = "./modules/lambda-monthly-report"
  function_name      = "monthly-cost-report"
  athena_db          = module.athena.db_name
  athena_table       = module.athena.table_name
  sns_topic_arn      = module.sns.topic_arn
  output_location    = "s3://${module.s3.bucket_name}/results/"
  archive_bucket     = module.s3.bucket_name
  archive_bucket_arn = module.s3.bucket_arn
  region             = var.region
}