output "db_name" {
  value = aws_glue_catalog_database.cur.name
}

output "table_name" {
  value = aws_glue_catalog_table.report.name
}