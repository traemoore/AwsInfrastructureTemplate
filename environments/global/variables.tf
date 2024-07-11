locals {
  primary_region     = "us-east-1"
  environment        = "global"
  availability_zones = [
    "us-east-1a", "us-east-1b" , "us-east-1c"
    ]
}

variable "resource_prefix" {
  type = string
}