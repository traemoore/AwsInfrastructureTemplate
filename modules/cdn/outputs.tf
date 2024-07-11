output "cdn_id" {
  description = "The identifier for the distribution."
  value       = aws_cloudfront_distribution.this.id
}

output "cdn_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution."
  value       = aws_cloudfront_distribution.this.arn
}

output "cdn_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cdn_status" {
  description = "The current status of the distribution."
  value       = aws_cloudfront_distribution.this.status
}

output "cdn_enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content."
  value       = aws_cloudfront_distribution.this.enabled
}

output "cdn_in_use" {
  description = "Whether the distribution is currently in use."
  value       = aws_cloudfront_distribution.this.in_use
}

output "cdn_last_modified_time" {
  description = "The date and time the distribution was last modified."
  value       = aws_cloudfront_distribution.this.last_modified_time
}

output "waf_acl_id" {
  description = "The ID of the WAF ACL"
  value       = aws_wafv2_web_acl.this.id
}

output "waf_acl_arn" {
  description = "The ARN of the WAF ACL"
  value       = aws_wafv2_web_acl.this.arn
}

output "waf_acl_capacity" {
  description = "The capacity of the WAF ACL"
  value       = aws_wafv2_web_acl.this.capacity
}
