locals {
  primary_region     = "us-east-2"
  environment        = "dev"
  availability_zones = [
    "us-east-2a", "us-east-2b" #, "us-east-2c"
    ]
}

variable "resource_prefix" {
  type = string
}

variable "rds_username" {
  description = "Username for RDS"
  type        = string
}

variable "rds_password" {
  description = "Username for RDS"
  type        = string
}