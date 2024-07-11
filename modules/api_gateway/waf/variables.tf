variable "waf_name" {
  description = "The name of the WAF ACL"
  type        = string
}

variable "waf_metric_name" {
  description = "The metric name for the WAF ACL"
  type        = string
}

variable "rest_api_id" {
  description = "The ID of the REST API to associate with the WAF"
  type        = string
}

variable "stage_name" {
  description = "The name of the API Gateway stage"
  type        = string
}

variable "deployment_id" {
  description = "The ID of the API Gateway deployment"
  type        = string
}
