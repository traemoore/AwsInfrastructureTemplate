output "cognito_user_pool_client_id" {
  description = "The ID of the Cognito User Pool Client."
  value       = aws_cognito_user_pool_client.this.id
}

output "cognito_user_pool_client_secret" {
  description = "The client secret of the Cognito User Pool Client."
  value       = aws_cognito_user_pool_client.this.client_secret
}

output "cognito_user_pool_client_creation_date" {
  description = "The date the Cognito User Pool Client was created."
  value       = aws_cognito_user_pool_client.this.creation_date
}

output "cognito_user_pool_client_last_modified_date" {
  description = "The date the Cognito User Pool Client was last modified."
  value       = aws_cognito_user_pool_client.this.last_modified_date
}
