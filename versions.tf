terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.20.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }

  backend "s3" {
    region = "us-east-2"
    bucket = "template-unmanaged"
    key    = "infra.tfstate"
  }

  required_version = ">= 0.14"
}
