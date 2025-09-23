variable "region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, prod)"
}