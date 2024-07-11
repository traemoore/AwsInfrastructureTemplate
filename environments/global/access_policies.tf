
resource "aws_iam_policy" "lambda_s3_read_policy" {
  name        = "${local.resource_prefix}-${local.environment}-cognito-s3-read-policy"
  description = "Allows Lambda to read from S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
        ],
        Effect = "Allow",
        Resource = [
          "arn:aws:s3:::${module.cognito_lambda_binaries_bucket.bucket_name}/*",
        ],
      },
    ],
  })
}

resource "aws_iam_policy" "lambda_rds_connection_policy" {
  name        = "lambda-rds-connect-policy"
  description = "Policy for Lambda functions to access RDS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "rds-db:connect",
          "rds-db:connect",
        ],
        Effect   = "Allow",
        Resource = "*",
      },
      {
        Action   = "logs:CreateLogGroup",
        Effect   = "Allow",
        Resource = "*",
      },
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*",
      },
    ],
  })
}