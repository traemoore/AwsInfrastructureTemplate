locals {
  flattened_resources = flatten([
    for res in var.api_resources : [
      for method in res.methods : {
        path_part     = res.path_part,
        http_method   = method.http_method,
        authorization = method.authorization,
        uri           = method.uri
      }
    ]
  ])
}

resource "aws_api_gateway_rest_api" "this" {
  name        = var.api_name
  description = var.api_description
  endpoint_configuration {
    types = var.endpoint_types
  }
}

resource "aws_api_gateway_resource" "this" {
  for_each    = { for rsc in var.api_resources : rsc.path_part => rsc }
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = each.key
}

resource "aws_api_gateway_method" "this" {
  for_each      = { for item in local.flattened_resources : "${item.path_part}-${item.http_method}" => item }
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this[item.path_part].id
  http_method   = each.value.http_method
  authorization = each.value.authorization
}

resource "aws_api_gateway_integration" "this" {
  for_each = { for item in local.flattened_resources : "${item.path_part}-${item.http_method}" => item }
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this[item.path_part].id
  http_method = each.value.http_method

  integration_http_method = each.value.http_method
  type                    = "AWS_PROXY"
  uri                     = each.value.uri
}