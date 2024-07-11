output "rule_id" {
  description = "The ID of the WAF rule."
  value       = aws_wafv2_web_acl.this.id
}
