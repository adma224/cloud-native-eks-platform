variable "cluster_name" {
  type        = string
  description = "EKS cluster name (used in subnet tags)"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

# Two AZs for simplicity
variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.32.0/20", "10.0.48.0/20"]
}
