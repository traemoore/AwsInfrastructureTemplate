variable "client_name" {
  description = "The name of the app client."
  type        = string
}

variable "user_pool_id" {
  description = "The ID of the Cognito User Pool to associate with the client."
  type        = string
}

variable "callback_urls" {
  description = "List of callback URLs for the app client."
  type        = list(string)
  # TODO remove from here and put in envs.
  default     = ["https://players.template.games/auth_verified", "template-space-cartel://auth_verified"]
}

variable "default_redirect_uri" {
  description = "Default redirect URI for the app client."
  type        = string
  # TODO remove from here and put in envs.
  default     = "https://auth.template.games/auth_verified"
}

variable "allowed_oauth_flows" {
  description = "List of allowed OAuth flows."
  type        = list(string)
  default     = ["code", "implicit"]
}

variable "allowed_oauth_scopes" {
  description = "List of allowed OAuth scopes."
  type        = list(string)
  default     = ["phone", "email", "openid", "profile"]
}
