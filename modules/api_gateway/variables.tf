variable "api_name" {
  description = "The name of the REST API"
  type        = string
}

variable "api_description" {
  description = "Description for the REST API"
  type        = string
  default     = "API Gateway REST API"
}

variable "endpoint_types" {
  description = "A list of endpoint types of an API or its custom domain name"
  type        = list(string)
  default     = ["REGIONAL"]
}
  
variable "api_resources" {
  description = "List of API resources to create"
  type = list(object({
    path_part   = string
    methods     = list(object({
      http_method   = string
      authorization = string
      uri           = string
    }))
  }))
  default = []
}