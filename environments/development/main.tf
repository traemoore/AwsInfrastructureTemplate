module "template_vpc" {
  source = "../../modules/vpc"
  vpc_cidr = "10.0.0.0/16"

  public_subnet_name = "public-subnet"
  public_subnet_cidrs = [
    "10.0.1.0/24", "10.0.2.0/24" #, "10.0.3.0/24"
  ]
  
  private_subnet_name = "private-subnet"
  private_subnet_cidrs = [
    "10.0.11.0/24", "10.0.12.0/24" #, "10.0.13.0/24"
  ]

  availability_zones = local.availability_zones
  vpc_name = "${var.resource_prefix}-${local.environment}-${local.primary_region}-vpc"
  environment = local.environment
}

resource "aws_db_subnet_group" "public_subnets_group" {
  name       = "${var.resource_prefix}-${local.environment}-db-subnet-group"
  subnet_ids = module.template_vpc.public_subnets

  tags = {
    Name        = "${var.resource_prefix}-${local.environment}-db-subnet-group"
    Environment = local.environment
  }
}

# Security Group to allow RDS access
resource "aws_security_group" "default_rds_sg" {
  vpc_id = module.template_vpc.vpc_id
  name   = "${var.resource_prefix}-${local.environment}-default-rds-sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["47.32.243.89/32"]
  }

  tags = {
    Name = "Default RDS Security Group"
  }
}

module "secure_user_db" {
  source = "../../modules/rds"

  instance_name     = "${var.resource_prefix}-${local.environment}-users-db"
  db_name           = "UsersDB"
  apply_immediately = true
  allocated_storage = 10
  instance_class    = "db.t3.micro"
  engine            = "postgres"
  engine_version    = "15.3"
  username          = var.rds_username
  password          = var.rds_password
  subnet_group_name = aws_db_subnet_group.public_subnets_group.name
  vpc_security_group_ids = [
    aws_security_group.default_rds_sg.id
    # module.lambda_sg.id
  ]
  storage_encrypted   = true
  publicly_accessible = true
  multi_az            = false
  ca_cert_identifier  = "rds-ca-rsa4096-g1"
  availability_zone   = local.availability_zones[1]
  deletion_protection = false
  #   option_group_name = "option_group_name"
  #   backup_window = "backup_window"
  #   maintenance_window = "maintenance_window"

  tags = {
    Name        = "${var.resource_prefix}-${local.environment}-users-db"
    Description = "${local.environment} Users Database"
    Environment = local.environment
    Region      = local.primary_region
  }
}

