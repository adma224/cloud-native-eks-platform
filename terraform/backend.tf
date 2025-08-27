terraform {
  backend "s3" {
    bucket       = "org-adrian-aws-eks-app-platform-tfstate-924917171175"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    # use_lockfile avoids the deprecation warning (replace your dynamodb_table line)
    use_lockfile = true
  }

  required_version = ">= 1.13.0"



  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.33, < 6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
}
