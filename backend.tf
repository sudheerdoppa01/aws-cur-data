terraform {
  backend "s3" {
    bucket         = "terraform-state-cost-report-dev"
    key            = "cost-report/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-dev"
    encrypt        = true
  }
}