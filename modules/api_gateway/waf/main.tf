resource "aws_waf_web_acl" "this" {
  name        = var.waf_name
  metric_name = var.waf_metric_name

  default_action {
    type = "ALLOW"
  }

  # Add rules here as needed
}

resource "aws_api_gateway_stage" "waf_association" {
  rest_api_id   = var.rest_api_id
  stage_name    = var.stage_name
  deployment_id = var.deployment_id

  web_acl_arn = aws_waf_web_acl.this.arn
}
