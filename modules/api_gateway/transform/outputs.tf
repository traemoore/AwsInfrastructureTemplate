output "integration_response_id" {
  description = "The ID of the integration response."
  value       = aws_api_gateway_integration_response.this.id
}

output "integration_response_response_type" {
  description = "The response type of the integration response."
  value       = aws_api_gateway_integration_response.this.response_type
}
