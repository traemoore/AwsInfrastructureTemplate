variable "name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "description" {
  description = "The description of the IAM policy"
  type        = string
  default     = ""
}

variable "policy" {
  description = "The policy document. This is a nested map."
  type        = any
}
