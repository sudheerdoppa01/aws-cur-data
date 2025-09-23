resource "aws_glue_catalog_database" "this" {
  name        = var.database_name
  description = var.database_description
}

resource "aws_glue_catalog_table" "this" {
  name          = var.table_name
  database_name = aws_glue_catalog_database.this.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification"   = "parquet"
    "compressionType"  = "none"
    "typeOfData"       = "file"
  }

  storage_descriptor {
    location      = var.s3_location
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
    compressed    = false
    number_of_buckets = -1

    serde_info {
      name                  = "parquet"
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
    }

    columns = var.table_columns
  }
}