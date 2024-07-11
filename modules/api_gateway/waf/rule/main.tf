locals {
  active_rules = [for rule in var.waf_rules : rule if rule.active]
}

resource "aws_wafv2_web_acl" "this" {
  name        = var.name
  description = var.description
  scope       = var.scope

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "defaultMetricName"
    sampled_requests_enabled   = true
  }

  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = local.active_rules

    content {
      name     = rule.value.name
      priority = rule.value.priority

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = true
      }

      dynamic "statement" {
        for_each = [rule.value.statement]
        content {
          # rate_based_statement
          dynamic "rate_based_statement" {
            for_each = lookup(statement.value, "rate_based_statement", null) != null ? [statement.value.rate_based_statement] : []
            content {
              limit              = rate_based_statement.value.limit
              aggregate_key_type = rate_based_statement.value.aggregate_key_type
            }
          }

          # size_constraint_statement
          dynamic "size_constraint_statement" {
            for_each = lookup(statement.value, "size_constraint_statement", null) != null ? [statement.value.size_constraint_statement] : []
            content {
              field_to_match {
                all_query_arguments {}
              }
              comparison_operator = size_constraint_statement.value.comparison_operator
              size                = size_constraint_statement.value.size
              text_transformation {
                priority = size_constraint_statement.value.priority
                type     = size_constraint_statement.value.type
              }
            }
          }

          # regex_pattern_set_reference_statement
          dynamic "regex_pattern_set_reference_statement" {
            for_each = lookup(statement.value, "regex_pattern_set_reference_statement", null) != null ? [statement.value.regex_pattern_set_reference_statement] : []
            content {
              arn = regex_pattern_set_reference_statement.value.arn
              text_transformation {
                priority = regex_pattern_set_reference_statement.value.priority
                type     = regex_pattern_set_reference_statement.value.type
              }
            }
          }

          # geo_match_statement
          dynamic "geo_match_statement" {
            for_each = lookup(statement.value, "geo_match_statement", null) != null ? [statement.value.geo_match_statement] : []
            content {
              country_codes = geo_match_statement.value.country_codes
            }
          }

          # xss_match_statement
          dynamic "xss_match_statement" {
            for_each = lookup(statement.value, "xss_match_statement", null) != null ? [statement.value.xss_match_statement] : []
            content {
              field_to_match {
                all_query_arguments {}
              }
              text_transformation {
                priority = xss_match_statement.value.priority
                type     = xss_match_statement.value.type
              }
            }
          }

          # sqli_match_statement
          dynamic "sqli_match_statement" {
            for_each = lookup(statement.value, "sqli_match_statement", null) != null ? [statement.value.sqli_match_statement] : []
            content {
              field_to_match {
                all_query_arguments {}
              }
              text_transformation {
                priority = sqli_match_statement.value.priority
                type     = sqli_match_statement.value.type
              }
            }
          }

          # byte_match_statement
          dynamic "byte_match_statement" {
            for_each = lookup(statement.value, "byte_match_statement", null) != null ? [statement.value.byte_match_statement] : []
            content {
              field_to_match {
                all_query_arguments {}
              }
              positional_constraint = byte_match_statement.value.positional_constraint
              search_string         = byte_match_statement.value.search_string
              text_transformation {
                priority = byte_match_statement.value.priority
                type     = byte_match_statement.value.type
              }
            }
          }
        }
      }
    }
  }
  
  tags = var.tags
}
