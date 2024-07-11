variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "ssh_access_cidrs" {
  description = "List of CIDR blocks that are allowed SSH access to EC2 instances"
  type        = list(string)
  default     = [] # Default to allow from anywhere, but you should override this in module declaration.
}

variable "rds_access_cidrs" {
  description = "List of CIDR blocks that are allowed access to RDS instances"
  type        = list(string)
  default     = [] # Default to allow from anywhere, but you should override this in module declaration.
}

variable "vpc_name" {
  description = "Name of the subnet"
  type        = string
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  type        = string
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}