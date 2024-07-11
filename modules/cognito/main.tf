resource "aws_cognito_user_pool" "this" {
  name = var.pool_name

  password_policy {
    minimum_length    = var.password_policy.min_length
    require_uppercase = var.password_policy.require_uppercase
    require_lowercase = var.password_policy.require_lowercase
    require_numbers   = var.password_policy.require_numbers
    require_symbols   = var.password_policy.require_symbols
  }

  lambda_config {
    pre_sign_up                = var.pre_signup_lambda_arn
    post_confirmation          = var.post_confirmation_lambda_arn
    pre_authentication         = var.pre_authentication_lambda_arn
    post_authentication        = var.post_authentication_lambda_arn
  }

  dynamic "schema" {
    for_each = var.custom_attributes
    content {
      name                 = schema.value.name
      attribute_data_type  = schema.value.data_type
      required             = schema.value.required
      developer_only_attribute = lookup(schema.value, "developer_only_attribute", null)
      mutable              = lookup(schema.value, "mutable", true)
      string_attribute_constraints {
        min_length = lookup(schema.value.string_attribute_constraints, "min_length", null)
        max_length = lookup(schema.value.string_attribute_constraints, "max_length", null)
      }
    }
  }

  # Assuming you'll have a device configuration
  device_configuration {
    challenge_required_on_new_device      = var.challenge_required_on_new_device
    device_only_remembered_on_user_prompt = var.device_only_remembered_on_user_prompt
  }

  # Assuming you'll have email configuration
  email_configuration {
    source_arn      = var.email_source_arn
    reply_to_email_address = var.reply_to_email_address
    email_sending_account  = var.email_sending_account
  }

  # Assuming you'll have SMS configuration
  sms_configuration {
    external_id    = var.sms_external_id
    sns_caller_arn = var.sns_caller_arn
  }

  # Assuming you'll have MFA and software token MFA configuration
  mfa_configuration = var.mfa_configuration
  software_token_mfa_configuration {
    enabled = var.software_token_mfa_enabled
  }

  # Assuming you'll have account recovery setting
  account_recovery_setting {
    recovery_mechanism {
      name     = var.recovery_mechanism_name
      priority = var.recovery_mechanism_priority
    }
  }
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = var.domain_name
  user_pool_id = aws_cognito_user_pool.this.id
}