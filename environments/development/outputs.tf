output "vpc_id" {
  value = module.template_vpc.vpc_id
}

output "vpc_cidr" {
    value = module.template_vpc.vpc_cidr
}

output "vpc_owner_id" {
    value = module.template_vpc.owner_id
}

output "public_route_table_id" {
  description = "public route table id"
  value       = module.template_vpc.public_route_table_id
}

output "private_route_table_id" {
  description = "private route table id"
  value       = module.template_vpc.public_route_table_id
}