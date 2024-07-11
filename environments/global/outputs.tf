output "dns_name_servers" {
  value = aws_route53_zone.auth_template_games.name_servers
}

output "dns_zone_id" {
  value = aws_route53_zone.auth_template_games.zone_id
}

output "ssl_certificate_arn" {
  value = aws_acm_certificate.wildcard_certificate.arn
}

output "vpc_id" {
  value = module.template_vpc.vpc_id
}

output "vpc_cidr" {
    value = module.template_vpc.vpc_cidr
}

output "public_route_table_id" {
  description = "public route table id"
  value       = module.template_vpc.public_route_table_id
}

output "private_route_table_id" {
  description = "private route table id"
  value       = module.template_vpc.public_route_table_id
}