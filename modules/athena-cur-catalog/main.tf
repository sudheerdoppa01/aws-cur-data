resource "aws_glue_catalog_database" "cur" {
  name = var.db_name
}

resource "aws_glue_catalog_table" "report" {
  name          = var.table_name
  database_name = aws_glue_catalog_database.cur.name
  table_type    = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = var.s3_location
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
  ser_de_info {
    name                  = "cur-serde"
    serialization_library = "org.openx.data.jsonserde.JsonSerDe"
  }

    columns {
      name = "line_item_usage_account_id"
      type = "string"
    }
    columns {
      name = "line_item_unblended_cost"
      type = "double"
    }
    columns {
      name = "year"
      type = "string"
    }
    columns {
      name = "month"
      type = "string"
    }
  }
}
