locals {
  cognito_pre_signup_lambda           = "cognito_pre_signup_lambda.zip"
  cognito_post_authentication_lambda  = "cognito_post_authentication_lambda.zip"
  cognito_pre_authentication_lambda   = "cognito_pre_authentication_lambda.zip"
  cognito_post_confirmation_lambda    = "cognito_post_confirmation_lambda.zip"
  cognito_pre_token_generation_lambda = "cognito_pre_token_generation_lambda.zip"
  reply_to_email_address              = "welcome@template.com"
  cognito_lambda_binaries_bucket_name = "template-cognito-lambda-binaries"
  domain_name                         = "auth.template.games"
  resource_prefix                     = "template"
}

# KMS key for lambda custom sender config"
# resource "aws_kms_key" "lambda-custom-sender" {
#   description = "KMS key for cognito lambda custom sender config"
# }

# SES Email Identity (if you're verifying an individual email instead of a domain)
resource "aws_ses_email_identity" "this" {
  email = local.reply_to_email_address
}

resource "aws_cognito_user_pool_domain" "main" {
  domain          = local.domain_name
  certificate_arn = aws_acm_certificate.wildcard_certificate.arn
  user_pool_id    = module.cognito_user_pool.id
}
module "cognito_user_pool" {
  depends_on = [
    module.cognito_post_authentication_lambda,
    module.cognito_post_confirmation_lambda,
    module.cognito_pre_authentication_lambda,
    module.cognito_pre_signup_lambda,
    module.cognito_pre_token_generation_lambda
  ]
  source = "lgallard/cognito-user-pool/aws"

  user_pool_name = "${local.resource_prefix}-${local.environment}-global-user-pool"
  alias_attributes = [
    "email",
    # "phone_number"
  ]
  auto_verified_attributes = ["email"]
  # sms_authentication_message = "Your username is {username} and temporary password is {####}."
  # sms_verification_message   = "This is the verification message {####}."

  deletion_protection = "ACTIVE"

  mfa_configuration = "OPTIONAL"
  software_token_mfa_configuration = {
    enabled = true
  }

  admin_create_user_config = {
    email_message = "Dear {username}, your verification code is {####}."
    email_subject = "Here, your verification"
    sms_message   = "Your username is {username} and temporary password is {####}."
  }

  device_configuration = {
    challenge_required_on_new_device      = false
    device_only_remembered_on_user_prompt = true
  }

  email_configuration = {
    email_sending_account  = "DEVELOPER"
    reply_to_email_address = local.reply_to_email_address
    source_arn             = aws_ses_email_identity.this.arn
  }

  lambda_config = {
    #create_auth_challenge          = "arn:aws:lambda:us-east-1:123456789012:function:create_auth_challenge"
    #custom_message                 = "arn:aws:lambda:us-east-1:123456789012:function:custom_message"
    #define_auth_challenge          = "arn:aws:lambda:us-east-1:123456789012:function:define_auth_challenge"
    post_authentication  = module.cognito_post_authentication_lambda.lambda_function_arn
    post_confirmation    = module.cognito_post_confirmation_lambda.lambda_function_arn
    pre_authentication   = module.cognito_pre_authentication_lambda.lambda_function_arn
    pre_sign_up          = module.cognito_pre_signup_lambda.lambda_function_arn
    pre_token_generation = module.cognito_pre_token_generation_lambda.lambda_function_arn
    #user_migration                 = "arn:aws:lambda:us-east-1:123456789012:function:user_migration"
    #verify_auth_challenge_response = "arn:aws:lambda:us-east-1:123456789012:function:verify_auth_challenge_response"
    # kms_key_id                     = aws_kms_key.lambda-custom-sender.arn
    # custom_email_sender = {
    #   lambda_arn     = "arn:aws:lambda:us-east-1:123456789012:function:custom_email_sender"
    #   lambda_version = "V1_0"
    # }
    # custom_sms_sender = {
    #   lambda_arn     = "arn:aws:lambda:us-east-1:123456789012:function:custom_sms_sender"
    #   lambda_version = "V1_0"
    # }
  }

  password_policy = {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 30

  }

  user_pool_add_ons = {
    advanced_security_mode = "ENFORCED"
  }

  verification_message_template = {
    default_email_option = "CONFIRM_WITH_CODE"
  }

  schemas = [
    {
      attribute_data_type      = "Boolean"
      developer_only_attribute = false
      mutable                  = true
      name                     = "active"
      required                 = false
    },
    # {
    #   attribute_data_type      = "Boolean"
    #   developer_only_attribute = true
    #   mutable                  = true
    #   name                     = "registration_confirmed"
    #   required                 = false
    # }
  ]

  string_schemas = [
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = false
      name                     = "email"
      required                 = true
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = false
      name                     = "description"
      required                 = false
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "imx_passport_id"
      required                 = false
    }
  ]

  number_schemas = [
    # {
    #   attribute_data_type      = "Number"
    #   developer_only_attribute = true
    #   mutable                  = true
    #   name                     = "mynumber1"
    #   required                 = false

    #   number_attribute_constraints = {
    #     min_value = 2
    #     max_value = 6
    #   }
    # },
    # {
    #   attribute_data_type      = "Number"
    #   developer_only_attribute = true
    #   mutable                  = true
    #   name                     = "mynumber2"
    #   required                 = false

    #   number_attribute_constraints = {
    #     min_value = 2
    #     max_value = 6
    #   }
    # },
  ]

  # user_pool_domain
  # domain = "https://auth.template.games" 

  # clients
  clients = [
    # {
    #   allowed_oauth_flows                  = []
    #   allowed_oauth_flows_user_pool_client = false
    #   allowed_oauth_scopes                 = []
    #   callback_urls                        = ["https://player.template.games/auth"]
    #   default_redirect_uri                 = "https://player.template.games/auth"
    #   explicit_auth_flows                  = ["USER_PASSWORD_AUTH"]
    #   generate_secret                      = true
    #   logout_urls                          = ["https://player.template.games/logout/{username}"]
    #   name                                 = "player-portal"
    #   read_attributes                      = ["email", "imx_passport_id"]
    #   supported_identity_providers         = []
    #   write_attributes                     = ["imx_passport_id"]
    #   access_token_validity                = 3
    #   id_token_validity                    = 1
    #   refresh_token_validity               = 1
    #   token_validity_units = {
    #     access_token  = "hours"
    #     id_token      = "days"
    #     refresh_token = "days"
    #   }
    # },
    # {
    #   allowed_oauth_flows                  = []
    #   allowed_oauth_flows_user_pool_client = false
    #   allowed_oauth_scopes                 = []
    #   callback_urls                        = ["https://mydomain.com/callback"]
    #   default_redirect_uri                 = "https://mydomain.com/callback"
    #   explicit_auth_flows                  = []
    #   generate_secret                      = false
    #   logout_urls                          = []
    #   name                                 = "test2"
    #   read_attributes                      = []
    #   supported_identity_providers         = []
    #   write_attributes                     = []
    #   refresh_token_validity               = 30
    # },
    # {
    #   allowed_oauth_flows                  = ["code", "implicit"]
    #   allowed_oauth_flows_user_pool_client = true
    #   allowed_oauth_scopes                 = ["email", "openid"]
    #   callback_urls                        = ["https://mydomain.com/callback"]
    #   default_redirect_uri                 = "https://mydomain.com/callback"
    #   explicit_auth_flows                  = ["CUSTOM_AUTH_FLOW_ONLY", "ADMIN_NO_SRP_AUTH"]
    #   generate_secret                      = false
    #   logout_urls                          = ["https://mydomain.com/logout"]
    #   name                                 = "test3"
    #   read_attributes                      = ["email", "phone_number"]
    #   supported_identity_providers         = []
    #   write_attributes                     = ["email", "gender", "locale", ]
    #   refresh_token_validity               = 30
    # }
  ]

  # user_group
  user_groups = [
    {
      name        = "service-accounts"
      description = "template Service Accounts Group"
    },
    {
      name        = "player"
      description = "GSC Player Group"
    },
    {
      name        = "employee"
      description = "Template Employee Group"
    },
    {
      name        = "admin"
      description = "Template Admin Group"
    },
    {
      name        = "superadmin"
      description = "Template Super Admin Group"
    },
    {
      name        = "tester",
      description = "Template Tester Group"
    },
    {
      name        = "developer",
      description = "Template Developer Group"
    },
    {
      name        = "investor",
      description = "Template Investor Group"
    }
  ]

  resource_servers = [
    # {
    #   identifier = "https://api.template.games" # Assuming this is the API endpoint you want to protect
    #   name       = "template-games-api"         # A more descriptive name for the resource server
    #   scope = [
    #     {
    #       scope_name        = "player"
    #       scope_description = "Access to player-specific resources and operations."
    #     },
    #     {
    #       scope_name        = "employee"
    #       scope_description = "Access to internal employee resources and operations."
    #     },
    #   ]
    # }
  ]


  # identity_providers
  # identity_providers = [
  #   {
  #     provider_name = "Google"
  #     provider_type = "Google"

  #     provider_details = {
  #       authorize_scopes              = "email"
  #       client_id                     = "your client_id"
  #       client_secret                 = "your client_secret"
  #       attributes_url_add_attributes = "true"
  #       authorize_url                 = "https://accounts.google.com/o/oauth2/v2/auth"
  #       oidc_issuer                   = "https://accounts.google.com"
  #       token_request_method          = "POST"
  #       token_url                     = "https://www.googleapis.com/oauth2/v4/token"
  #     }

  #     attribute_mapping = {
  #       email    = "email"
  #       username = "sub"
  #       gender   = "gender"
  #     }
  #   }
  # ]

  # tags
  tags = {
    Owner       = "infra"
    Environment = local.environment
    Terraform   = true
  }
}

module "cognito_lambda_sg" {
  source      = "../../modules/security_group"
  name        = "${local.resource_prefix}-${local.environment}-cognito-lambda-sg"
  description = "Security group for cognito lambdas"
  vpc_id      = module.template_vpc.vpc_id
  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = []
    }
  ]
}

module "cognito_lambda_binaries_bucket" {
  source      = "../../modules/s3"
  bucket_name = local.cognito_lambda_binaries_bucket_name
}

data "aws_iam_policy_document" "lambda_ec2_permissions" {
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DetachNetworkInterface"
    ]
    resources = ["*"] # Adjust resource ARNs as needed
  }
}


resource "aws_iam_role" "cognito_callbacks_role" {
  name = "${local.resource_prefix}-${local.environment}-cognito-callbacks-role"

  inline_policy {
    name        = "lambda_ec2_permissions_policy"
    policy      = data.aws_iam_policy_document.lambda_ec2_permissions.json
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

locals {
  lambda_execution_policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  default_function_path       = "function_templates/python_function.zip"
  default_function_handler    = "lambda_function.lambda_handler"
}

module "cognito_pre_signup_lambda" {
  
  source         = "../../modules/lambda"
  function_name  = "${local.resource_prefix}-${local.environment}-cognito-pre-signup"
  handler        = local.default_function_handler
  runtime        = "python3.10"
  s3_bucket_name = module.cognito_lambda_binaries_bucket.bucket_name
  s3_key         = local.cognito_pre_signup_lambda
  # environment_variables = {
  #   "key1" = "value1"
  #   "key2" = "value2"
  # }
  subnet_ids         = module.template_vpc.private_subnets
  security_group_ids = [module.cognito_lambda_sg.id]
  tags = {
    Name        = "${local.resource_prefix}-${local.environment}-cognito-pre-signup"
    Environment = local.environment
  }
  policy_arns = [
    local.lambda_execution_policy_arn,
    aws_iam_policy.lambda_s3_read_policy.arn,
    aws_iam_policy.lambda_rds_connection_policy.arn
  ]
  s3_object = {
    source = local.default_function_path
    key    = local.cognito_pre_signup_lambda
  }
  role = {
    arn  = aws_iam_role.cognito_callbacks_role.arn,
    name = aws_iam_role.cognito_callbacks_role.name
  }
}

module "cognito_post_confirmation_lambda" {
  
  source         = "../../modules/lambda"
  function_name  = "${local.resource_prefix}-${local.environment}-cognito-post-confirmation"
  handler        = local.default_function_handler
  runtime        = "python3.10"
  s3_bucket_name = module.cognito_lambda_binaries_bucket.bucket_name
  s3_key         = local.cognito_post_confirmation_lambda
  # environment_variables = {
  #   "key1" = "value1"
  #   "key2" = "value2"
  # }
  subnet_ids         = module.template_vpc.private_subnets
  security_group_ids = [module.cognito_lambda_sg.id]
  tags = {
    Name        = "${local.resource_prefix}-${local.environment}-cognito-post-confirmation"
    Environment = local.environment
  }
  policy_arns = [
    local.lambda_execution_policy_arn,
    aws_iam_policy.lambda_s3_read_policy.arn,
    aws_iam_policy.lambda_rds_connection_policy.arn
  ]
  s3_object = {
    source = local.default_function_path
    key    = local.cognito_post_confirmation_lambda
  }
  role = {
    arn  = aws_iam_role.cognito_callbacks_role.arn,
    name = aws_iam_role.cognito_callbacks_role.name
  }
}

module "cognito_pre_authentication_lambda" {
  
  source         = "../../modules/lambda"
  function_name  = "${local.resource_prefix}-${local.environment}-cognito-pre-authentication"
  handler        = local.default_function_handler
  runtime        = "python3.10"
  s3_bucket_name = module.cognito_lambda_binaries_bucket.bucket_name
  s3_key         = local.cognito_pre_authentication_lambda
  # environment_variables = {
  #   "key1" = "value1"
  #   "key2" = "value2"
  # }
  subnet_ids         = module.template_vpc.private_subnets
  security_group_ids = [module.cognito_lambda_sg.id]
  tags = {
    Name        = "${local.resource_prefix}-${local.environment}-cognito-pre-authentication"
    Environment = local.environment
  }
  policy_arns = [
    local.lambda_execution_policy_arn,
    aws_iam_policy.lambda_s3_read_policy.arn,
    aws_iam_policy.lambda_rds_connection_policy.arn
  ]
  s3_object = {
    source = local.default_function_path
    key    = local.cognito_pre_authentication_lambda
  }
  role = {
    arn  = aws_iam_role.cognito_callbacks_role.arn,
    name = aws_iam_role.cognito_callbacks_role.name
  }
}

module "cognito_post_authentication_lambda" {
  source         = "../../modules/lambda"
  function_name  = "${local.resource_prefix}-${local.environment}-cognito-post-authentication"
  handler        = local.default_function_handler
  runtime        = "python3.10"
  s3_bucket_name = module.cognito_lambda_binaries_bucket.bucket_name
  s3_key         = local.cognito_post_authentication_lambda
  # environment_variables = {
  #   "key1" = "value1"
  #   "key2" = "value2"
  # }
  subnet_ids         = module.template_vpc.private_subnets
  security_group_ids = [module.cognito_lambda_sg.id]
  tags = {
    Name        = "${local.resource_prefix}-${local.environment}-cognito-post-authentication"
    Environment = local.environment
  }
  policy_arns = [
    local.lambda_execution_policy_arn,
    aws_iam_policy.lambda_s3_read_policy.arn,
    aws_iam_policy.lambda_rds_connection_policy.arn
  ]
  s3_object = {
    source = local.default_function_path
    key    = local.cognito_post_authentication_lambda
  }
  role = {
    arn  = aws_iam_role.cognito_callbacks_role.arn,
    name = aws_iam_role.cognito_callbacks_role.name
  }
}

module "cognito_pre_token_generation_lambda" {
  
  source         = "../../modules/lambda"
  function_name  = "${local.resource_prefix}-${local.environment}-cognito-pre-token-generation"
  handler        = local.default_function_handler
  runtime        = "python3.10"
  s3_bucket_name = module.cognito_lambda_binaries_bucket.bucket_name
  s3_key         = local.cognito_pre_token_generation_lambda
  # environment_variables = {
  #   "key1" = "value1"
  #   "key2" = "value2"
  # }
  subnet_ids         = module.template_vpc.private_subnets
  security_group_ids = [module.cognito_lambda_sg.id]
  tags = {
    Name        = "${local.resource_prefix}-${local.environment}-cognito-pre-token-generation"
    Environment = local.environment
  }
  policy_arns = [
    local.lambda_execution_policy_arn,
    aws_iam_policy.lambda_s3_read_policy.arn,
    aws_iam_policy.lambda_rds_connection_policy.arn
  ]
  s3_object = {
    source = local.default_function_path
    key    = local.cognito_pre_token_generation_lambda
  }
  role = {
    arn  = aws_iam_role.cognito_callbacks_role.arn,
    name = aws_iam_role.cognito_callbacks_role.name
  }
}

locals {
  statement_id = "AllowCognitoToInvokeFunction"
  action       = "lambda:InvokeFunction"
  principal    = "cognito-idp.amazonaws.com"
}

module "cognito_lambda_permissions" {
  source = "../../modules/lambda/permissions"

  permissions = [{
    statement_id  = local.statement_id
    action        = local.action
    function_name = module.cognito_pre_signup_lambda.lambda_function_name
    principal     = local.principal
    },
    {
      statement_id  = local.statement_id
      action        = local.action
      function_name = module.cognito_post_confirmation_lambda.lambda_function_name
      principal     = local.principal
    },
    {
      statement_id  = local.statement_id
      action        = local.action
      function_name = module.cognito_pre_authentication_lambda.lambda_function_name
      principal     = local.principal
    },
    {
      statement_id  = local.statement_id
      action        = local.action
      function_name = module.cognito_post_authentication_lambda.lambda_function_name
      principal     = local.principal
    },
    {
      statement_id  = local.statement_id
      action        = local.action
      function_name = module.cognito_pre_token_generation_lambda.lambda_function_name
      principal     = local.principal
  }]
}
