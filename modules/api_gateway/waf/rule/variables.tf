variable "name" {
  description = "The name of the WAF rule."
  type        = string
}

variable "scope" {
  description = "The scope of the WAF rule."
  type        = string
}

variable "description" {
  description = "The description of the WAF rule."
  type        = string
}

variable "metric_name" {
  description = "The name or description for the Amazon CloudWatch metric of this rule."
  type        = string
}

variable "rule_action" {
  description = "The action that AWS WAF should take on a web request when it matches the rule's statement."
  type        = string
  default     = "ALLOW"
}

variable "waf_rules" {
  description = "The list of WAF rules to create."
  type        = list(object({
    name        = string
    priority    = number
    metric_name = string
    active   = string
    statement   = any
  }))
  default = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}