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

# Discover the cluster connection details (plan-time friendly)
data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = var.cluster_name
}

# Kubernetes provider -> uses the live endpoint/CA/token
provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}
