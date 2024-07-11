output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.this.arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "attached_policy_arns" {
  description = "ARNs of the policies attached to the Lambda execution role"
  value       = [for arn in var.policy_arns : arn]
}
