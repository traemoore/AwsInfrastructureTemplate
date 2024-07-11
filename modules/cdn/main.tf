resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = var.origin_domain_name
    origin_id   = var.origin_id

    custom_origin_config {
      http_port              = var.http_port
      https_port             = var.https_port
      origin_protocol_policy = var.origin_protocol_policy
      origin_ssl_protocols   = var.origin_ssl_protocols
    }
  }
  price_class = var.price_class
  web_acl_id  = var.waf_acl_id

  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  comment             = var.comment
  default_root_object = var.default_root_object

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = var.origin_id

    forwarded_values {
      query_string = var.forward_query_string
      cookies {
        forward = var.cookie_forwarding
      }
    }

    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.restricted_countries
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = var.tags
}

resource "aws_wafv2_regex_pattern_set" "this" {
  name  = "userAgentPatternSet"
  scope = "REGIONAL" # or "CLOUDFRONT" depending on where you're using the WAF

  regular_expression {
    regex_string = var.user_agent_regex_string
  }
}

resource "aws_wafv2_web_acl" "this" {
  name        = "template-games-web-acl"
  description = "WAF ACL for Template CloudFront distribution"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "templateGamesWAFMetrics"
    sampled_requests_enabled   = true
  }

  ### Start rules

  # rule 1: xssRule
  rule {
    name     = "xssRule"
    priority = 0

    action {
      block {}
    }

    statement {
      xss_match_statement {
        field_to_match {
          all_query_arguments {}
        }
        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "xssRuleMetric"
      sampled_requests_enabled   = true
    }
  }

  # rule 2: rate based rule
  rule {
    name     = "rateLimitRule"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = var.rate_limit
        aggregate_key_type = "IP"
        scope_down_statement {
          geo_match_statement {
            country_codes = var.country_codes
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "rateLimitRuleMetric"
      sampled_requests_enabled   = true
    }
  }

  # rule 3: header check rule
  rule {
    name     = "headerCheckRule"
    priority = 2

    action {
      block {}
    }

    statement {
      regex_pattern_set_reference_statement {
        arn = aws_wafv2_regex_pattern_set.this.arn

        field_to_match {
          single_header {
            name = "user-agent"
          }
        }

        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "headerCheckRuleMetric"
      sampled_requests_enabled   = true
    }
  }

  ### End rules
  tags = var.tags
}

resource "aws_wafv2_web_acl_association" "waf_cdn_association" {
  resource_arn = aws_cloudfront_distribution.this.arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}