module "athena" {
  source         = "./modules/athena"
  database_name  = "cur_athena_db"
  table_name     = "cur_athena_table"
  output_bucket  = "aws-cost-optimization-report-testing"
  s3_location    = "data/"
}