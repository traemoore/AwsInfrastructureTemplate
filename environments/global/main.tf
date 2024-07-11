module "template_vpc" {
  source = "../../modules/vpc"
  vpc_cidr = "10.0.0.0/16"

  public_subnet_name = "global-public-subnet"
  public_subnet_cidrs = [
    "10.0.1.0/24", "10.0.2.0/24" , "10.0.3.0/24"
  ]
  
  private_subnet_name = "global-private-subnet"
  private_subnet_cidrs = [
    "10.0.11.0/24", "10.0.12.0/24" , "10.0.13.0/24"
  ]
  
  availability_zones = local.availability_zones
  vpc_name = "${var.resource_prefix}-${local.environment}-${local.primary_region}-vpc"
  environment = local.environment
}

resource "aws_route53_zone" "auth_template_games" {
  name = local.domain_name
}

resource "aws_route53_record" "auth_cognito_a_record" {
  name    = local.domain_name
  type    = "A"
  zone_id = aws_route53_zone.auth_template_games.zone_id
  alias {
    evaluate_target_health = false

    name    = aws_cognito_user_pool_domain.main.cloudfront_distribution
    zone_id = aws_cognito_user_pool_domain.main.cloudfront_distribution_zone_id
  }
}

resource "aws_acm_certificate" "wildcard_certificate" {
  domain_name       = "*.template.games"
  validation_method = "EMAIL"
  key_algorithm = "RSA_2048"

  tags = {
    Name = "Wildcard SSL Certificate"
  }
}

resource "aws_acm_certificate_validation" "template_subdomain" {
  certificate_arn         = aws_acm_certificate.wildcard_certificate.arn
}