terraform {
  backend "s3" {
    bucket         = "tf-state-yourname"
    key            = "eks/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-state-locks"
    encrypt        = true
  }
}