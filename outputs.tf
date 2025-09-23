output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}

output "sns_topic_arn" {
  value = module.sns.topic_arn
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}