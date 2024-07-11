variable "user_name" {
  description = "The name of the IAM user to create."
  type        = string
}

variable "path" {
  description = "Path in which to create the user."
  type        = string
  default     = "/"
}

variable "attached_policy_arns" {
  description = "List of ARNs of the managed policies you want to attach to the user."
  type        = list(string)
  default     = []
}

variable "create_login_profile" {
  description = "Whether to create a login profile for the user to allow AWS Console access."
  type        = bool
  default     = false
}

variable "password_reset_required" {
  description = "Whether the user is required to set a new password on next login."
  type        = bool
  default     = true
}

variable "default_password" {
  description = "Default password to set for the IAM user. The user will be required to change this password upon first login."
  type        = string
  default     = "ChangeMe123!"  # You can set a different default or make it required without a default
}
