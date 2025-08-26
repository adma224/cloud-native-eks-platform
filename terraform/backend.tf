terraform {
  backend "s3" {
    bucket       = "org-adrian-aws-eks-app-platform-tfstate-924917171175"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
