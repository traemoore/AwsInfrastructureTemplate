variable "rest_api_id" {
  description = "The ID of the associated REST API."
  type        = string
}

variable "resource_id" {
  description = "The ID of the resource associated with the integration response."
  type        = string
}

variable "http_method" {
  description = "The HTTP method (e.g., GET, POST, PUT, DELETE) for the integration response."
  type        = string
}

variable "status_code" {
  description = "The HTTP status code for the integration response."
  type        = string
  default     = "200"
}

variable "response_templates" {
  description = "The response templates map for the integration response. It maps content types (e.g., 'application/xml', 'application/json') to their respective templates."
  type        = map(string)
  default     = {}
}
