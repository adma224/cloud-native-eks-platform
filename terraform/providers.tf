provider "aws" {
  region = var.region

  default_tags {
    tags = {
      project = var.project
      env     = var.env
    }
  }
}

provider "tls" {}

data "aws_eks_cluster" "this" {
  name       = module.k8.cluster_name
  depends_on = [module.k8]
}

# Get a short-lived auth token for that cluster
data "aws_eks_cluster_auth" "this" {
  name       = module.k8.cluster_name
  depends_on = [module.k8]
}

# Kubernetes provider wired to your EKS control plane
provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}