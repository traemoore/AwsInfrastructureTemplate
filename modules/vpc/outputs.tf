# VPC
output "vpc_id" {
  description = "The ID of the main VPC"
  value       = aws_vpc.main.id
}

# Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = [for s in aws_subnet.public_subnets : s.id]
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = [for s in aws_subnet.private_subnets : s.id]
}

# Internet Gateway
output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.igw.id
}

# NAT Gateway
output "nat_gateway_ids" {
  description = "The ID of the NAT gateway"
  value       = aws_nat_gateway.nat_gw.id
}

# Flow Logs
output "flow_log_id" {
  description = "The ID of the VPC flow log"
  value       = module.vpc_flow_logs.bucket_id
}

output "flow_log_s3_bucket_arn" {
  description = "The ARN of the S3 bucket storing VPC flow logs"
  value       = module.vpc_flow_logs.bucket_arn
}

# Route Tables (if needed)
output "public_route_table_id" {
  description = "List of IDs of public route tables"
  value       = aws_route_table.public_route_table.id
}

output "private_route_table_id" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private_route_table.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = aws_vpc.main.owner_id
}