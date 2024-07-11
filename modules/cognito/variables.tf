variable "pool_name" {
  description = "The name of the Cognito User Pool"
  type        = string
}

variable "password_policy" {
  description = "Password policy for the Cognito User Pool"
  type = object({
    min_length      = number
    require_upper   = bool
    require_lower   = bool
    require_numbers = bool
    require_symbols = bool
  })
  default = {
    min_length      = 8
    require_upper   = true
    require_lower   = true
    require_numbers = true
    require_symbols = true
  }
}

variable "pre_signup_lambda_arn" {
  description = "ARN for the pre-signup Lambda function"
  type        = string
}

variable "post_confirmation_lambda_arn" {
  description = "ARN for the post-confirmation Lambda function"
  type        = string
}

variable "pre_authentication_lambda_arn" {
  description = "ARN for the pre-authentication Lambda function"
  type        = string
}

variable "post_authentication_lambda_arn" {
  description = "ARN for the post-authentication Lambda function"
  type        = string
}

variable "domain_name" {
  description = "Custom domain name for the hosted UI."
  default     = "auth.template.games"
}

variable "custom_attributes" {
  description = "Custom attributes for user registration."
  type        = list(object({
    name                   = string
    data_type              = string
    required               = bool
    description            = optional(string)
    developer_only_attribute = optional(bool)
    mutable                = optional(bool)
    string_attribute_constraints = optional(object({
      min_length = optional(string)
      max_length = optional(string)
    }))
  }))
  default = []
}

# Additional variables from the integrated response:

variable "challenge_required_on_new_device" {
  description = "Indicates whether a challenge is required on a new device."
  type        = bool
  default     = false
}

variable "device_only_remembered_on_user_prompt" {
  description = "If true, a device will only be remembered on user prompt."
  type        = bool
  default     = false
}

variable "email_source_arn" {
  description = "The ARN of the email source."
  type        = string
}

variable "reply_to_email_address" {
  description = "The REPLY-TO email address."
  type        = string
}

variable "email_sending_account" {
  description = "The email sending account."
  type        = string
  default     = "COGNITO_DEFAULT"
}

variable "sms_external_id" {
  description = "The external ID used in sending the SMS."
  type        = string
}

variable "sns_caller_arn" {
  description = "The ARN of the SNS caller."
  type        = string
}

variable "mfa_configuration" {
  description = "The MFA configuration."
  type        = string
  default     = "OPTIONAL"
}

variable "software_token_mfa_enabled" {
  description = "Indicates whether software token MFA is enabled."
  type        = bool
  default     = false
}

variable "recovery_mechanism_name" {
  description = "The name of the recovery mechanism."
  type        = string
  default     = "EMAIL"
}

variable "recovery_mechanism_priority" {
  description = "The priority of the recovery mechanism."
  type        = number
  default     = 1
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
