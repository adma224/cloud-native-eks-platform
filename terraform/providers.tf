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
  name = module.k8.cluster_name
  depends_on = [ module.k8 ]
}


data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
  depends_on = [ module.k8 ]
}


provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}