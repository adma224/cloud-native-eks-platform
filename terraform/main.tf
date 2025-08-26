# Identity/context
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Two AZs in the region
data "aws_availability_zones" "available" { state = "available" }

locals {
  name_prefix = "${var.project}"
  azs         = slice(data.aws_availability_zones.available.names, 0, 2)
}

# --- VPC module ---
module "vpc" {
  source = "./modules/vpc"

  name_prefix          = local.name_prefix
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = local.azs
}

# --- K8 module (skeleton for now; adds EKS later) ---
module "k8" {
  source = "./modules/k8"

  cluster_name        = var.cluster_name
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids
}
