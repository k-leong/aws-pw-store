terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.6.4"
}

provider "aws" {
  region = "us-west-1"
}

module "name" {
  source = "./aws_resources"
}