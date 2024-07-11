resource "aws_api_gateway_domain_name" "this" {
  domain_name              = var.custom_domain_name
  certificate_arn          = var.certificate_arn
}

resource "aws_api_gateway_base_path_mapping" "this" {
  api_id      = var.rest_api_id
  stage_name  = var.stage_name
  domain_name = aws_api_gateway_domain_name.this.domain_name
}
