module "glue" {
  source               = "./modules/glue"
  database_name        = "cur_database"
  table_name           = "cur_table"
  s3_location          = "s3://aws-cost-optimization-report-testing/data/"
}