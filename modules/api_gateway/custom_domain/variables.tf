variable "custom_domain_name" {
  description = "The custom domain name for the API Gateway"
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate for the custom domain"
  type        = string
}

variable "rest_api_id" {
  description = "The ID of the REST API to associate with the custom domain"
  type        = string
}

variable "stage_name" {
  description = "The name of the API Gateway stage"
  type        = string
}
