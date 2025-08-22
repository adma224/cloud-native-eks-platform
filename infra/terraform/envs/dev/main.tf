terraform {
  required_version = ">= 1.6.0"
  # Using local state for zero-setup. Your backend/ folder is kept as placeholder.
}

provider "aws" {
  region = var.region
}

# --- VPC ---
module "vpc" {
  source       = "../../modules/vpc"
  cluster_name = var.cluster_name
}

# --- EKS ---
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  # Only these 3 lines are changed to hardcoded values:
  cluster_endpoint_public_access       = true
  cluster_endpoint_private_access      = false
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
}

# --- K8s (providers + hello world workload) ---
module "k8s" {
  source           = "../../modules/k8s"
  cluster_name     = module.eks.cluster_name
  cluster_endpoint = module.eks.cluster_endpoint
  # ⚠️ Upstream EKS module exposes this as cluster_certificate_authority_data
  cluster_ca       = module.eks.cluster_certificate_authority_data
}
