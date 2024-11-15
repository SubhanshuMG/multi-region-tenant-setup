
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr
  region     = var.region
}

module "ecs" {
  source = "./modules/ecs"
  cluster_name = "multi-region-cluster-${var.region}"
  vpc_id       = module.vpc.vpc_id
  subnets      = module.vpc.private_subnets
}

module "rds" {
  source         = "./modules/rds"
  db_name        = var.db_name
  db_user        = var.db_user
  db_password    = var.db_password
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnets
}
        