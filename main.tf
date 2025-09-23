module "glue" {
  source               = "./modules/glue"
  database_name        = "cur_database"
  table_name           = "cur_table"
  s3_location          = "s3://aws-cost-optimization-report-testing/data/"
  table_columns        = [
    { name = "identity_line_item_id", type = "string" },
    { name = "bill_billing_period_start_date", type = "timestamp" },
    { name = "line_item_usage_account_id", type = "string" },
    # Add more columns as needed
  ]
}