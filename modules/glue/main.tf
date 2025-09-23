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
    location          = var.s3_location
    input_format      = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format     = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
    compressed        = false
    number_of_buckets = -1

    ser_de_info {
      name                  = "parquet"
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
    }

    columns {
      name = "identity_line_item_id"
      type = "string"
    }

    columns {
      name = "bill_billing_period_start_date"
      type = "timestamp"
    }

    columns {
      name = "line_item_usage_account_id"
      type = "string"
    }

    # Add more columns as needed using `columns` blocks
  }
}