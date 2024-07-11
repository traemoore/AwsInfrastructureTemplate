# outputs.tf

output "cognito_user_pool_id" {
  description = "The ID of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.id
}

output "cognito_user_pool_arn" {
  description = "The ARN of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.arn
}

output "cognito_user_pool_endpoint" {
  description = "The endpoint name of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.endpoint
}

output "cognito_user_pool_domain" {
  description = "The domain prefix or full domain name of the Cognito User Pool UI"
  value       = aws_cognito_user_pool_domain.this.domain
}

output "cognito_user_pool_client_id" {
  description = "The ID of the Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.this.id
}

output "cognito_user_pool_client_secret" {
  description = "The client secret of the Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.this.client_secret
}

output "cognito_user_pool_client_creation_date" {
  description = "The date the Cognito User Pool Client was created"
  value       = aws_cognito_user_pool_client.this.creation_date
}

output "cognito_user_pool_client_last_modified_date" {
  description = "The date the Cognito User Pool Client was last modified"
  value       = aws_cognito_user_pool_client.this.last_modified_date
}

# If you have other resources like Cognito Identity Pool, Cognito User Pool Domain, etc., you can add outputs for those as well.
