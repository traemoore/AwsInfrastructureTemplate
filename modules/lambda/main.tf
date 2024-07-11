resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = var.role.arn

  s3_bucket = var.s3_bucket_name
  s3_key    = var.s3_key

  # source_code_hash = var.source_code_hash

  environment {
    variables = var.environment_variables
  }

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  tags = var.tags
}

module "binary_object" {
  source = "../s3/objects"
  bucket = var.s3_bucket_name
  objects = [var.s3_object]
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.policy_arns)
  role       = var.role.name
  policy_arn = var.policy_arns[count.index]
}