
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-${var.public_subnet_name}-${count.index}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-${var.private_subnet_name}-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  # count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-internet-gateway"
  }
}

resource "aws_eip" "nat_eip" {
  #count  = length(aws_subnet.private_subnets)
  domain = "vpc"

  tags = {
    Name = "${var.vpc_name}-nat-elastic-ip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  # count         = length(aws_subnet.private_subnets)
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[1].id

  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }

   depends_on = [aws_eip.nat_eip, aws_subnet.public_subnets]
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }

   depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }

   depends_on = [aws_nat_gateway.nat_gw]
}

resource "aws_route_table_association" "public_rta" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rta" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
# end routing

module "vpc_flow_logs" {
  source      = "../s3"
  bucket_name = "${var.vpc_name}-flow-logs-bucket"

  tags = {
    Name = "${var.vpc_name}-flow-logs-bucket"
    Environment = var.environment
  }
}

# # VPC Endpoints for S3
# resource "aws_vpc_endpoint" "s3" {
#   vpc_id       = aws_vpc.main.id
#   service_name = "com.amazonaws.us-east-2.s3"
#   route_table_ids = toset(concat(
#     # [aws_route_table.primary_route_table.id],
#     [for rt in aws_route_table.private_route_tables : rt.id]
#   ))
# }

# resource "aws_security_group" "default_ec2_sg" {
#   name        = "EC2-SecurityGroup"
#   description = "Security group for EC2 instances"
#   vpc_id      = aws_vpc.main.id

#   # Allow SSH
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = var.ssh_access_cidrs
#   }

#   # Allow all internal VPC traffic
#   ingress {
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = [var.vpc_cidr]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "EC2 SG"
#   }
# }

