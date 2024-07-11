variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "The function entrypoint in your code"
  type        = string
}

variable "runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
}

variable "s3_bucket_name" {
  description = "The S3 bucket where the Lambda deployment package is stored"
  type        = string
}

variable "s3_key" {
  description = "The S3 key pointing to the Lambda deployment package"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  description = "List of subnet IDs for VPC configuration"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for VPC configuration"
  type        = list(string)
}

variable "policy_arns" {
  description = "List of IAM policy ARNs to attach to the Lambda execution role"
  type        = list(string)
  default     = []
}

variable "s3_object" {
  description = "S3 object to create"
  type        = map(string)
}

variable "role" {
  description = "IAM role for the Lambda function"
  type        = object({
    name = string
    arn  = string
  })
}