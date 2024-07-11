locals {
  resource_prefix = "template"
}

####### REGION Global

module "global" {
  source = "./environments/global"
  resource_prefix = local.resource_prefix
}

# outputs
output "name_servers" {
  value = module.global.dns_name_servers
}

output "zone_id" {
  value = module.global.dns_zone_id
}

output "ssl_certificate_arn" {
  value = module.global.ssl_certificate_arn
}

####### REGION Development

# module "development" {
#   source = "./environments/development"
#   resource_prefix = local.resource_prefix
# }

# module "production" {
#   source = "./environments/production"
# }

# Create VPC peering connection from the Global VPC to Development VPC
# resource "aws_vpc_peering_connection" "global_to_dev" {
#   provider           = aws.primary
#   vpc_id             = module.global.vpc_id
#   peer_vpc_id        = module.development.vpc_id
#   auto_accept        = true

#   tags = {
#     Name = "${resource_prefix}-vpc-peering-global-to-dev}"
#   }
# }

# resource "aws_vpc_peering_connection" "dev_to_global" {
#   provider              = aws.primary
#   vpc_id                = module.development.vpc_id
#   peer_vpc_id           = module.global.vpc_id
#   auto_accept           = true

#   tags = {
#     Name = "${resource_prefix}-vpc-peering-dev-to-global}"
#   }
# }

# # Create route tables in both VPCs for the peering connection
# resource "aws_route" "public_global_to_dev" {
#   route_table_id             = module.global.public_route_table_id 
#   destination_cidr_block     = module.development.vpc_cidr
#   vpc_peering_connection_id   = aws_vpc_peering_connection.global_to_dev.id
# }

# resource "aws_route" "private_global_to_dev" {
#   route_table_id             = module.global.private_route_table_id 
#   destination_cidr_block     = module.development.vpc_cidr
#   vpc_peering_connection_id   = aws_vpc_peering_connection.global_to_dev.id
# }

# resource "aws_route" "public_dev_to_global" {
#   route_table_id             = module.development.public_route_table_id 
#   destination_cidr_block     = module.global.vpc_cidr
#   vpc_peering_connection_id   = aws_vpc_peering_connection.dev_to_global.id
# }

// not sure if i need this
# resource "aws_route" "private_dev_to_global" {
#   route_table_id             = module.development.private_route_table_id 
#   destination_cidr_block     = module.global.vpc_cidr
#   vpc_peering_connection_id   = aws_vpc_peering_connection.dev_to_global.id
# }



# output "trae_super_admin_temp_password" {
#   value     = module.global.trae_super_admin_temp_password
#   sensitive = true
# }