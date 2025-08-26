variable "region" {
  type = string
  default = "us-east-1" 
}

variable "project" {
  type = string
  default = "project-eks-obs" 
}

variable "env" {
  type = string
  default = "dev" 
}

# Network inputs (same layout you already use)
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

# (Phase 1) Kubernetes inputs — used by the k8 module later
variable "cluster_name" {
  type    = string
  default = "obs-eks-dev"
}

variable "kubernetes_version" {
  type = string
  default = "1.30"
}

variable "node_instance_type" {
  type = string
  default = "t2.micro"
}

variable "node_desired_size" {
  type = number
  default = 2
}

variable "node_max_size" {
  type = number
  default = 3
}

variable "node_min_size" {
  type = number
  default = 1
}
