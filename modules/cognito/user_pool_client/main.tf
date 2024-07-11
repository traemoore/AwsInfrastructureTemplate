resource "aws_cognito_user_pool_client" "this" {
  name            = var.client_name
  user_pool_id    = var.user_pool_id
  callback_urls   = var.callback_urls
  default_redirect_uri = var.default_redirect_uri
  allowed_oauth_flows = var.allowed_oauth_flows
  allowed_oauth_scopes = var.allowed_oauth_scopes
  allowed_oauth_flows_user_pool_client = true
  generate_secret = false  # Set to true if you want Cognito to generate a client secret for you
}
