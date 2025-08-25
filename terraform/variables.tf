variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Project tag"
  type        = string
  default     = "obs-eks"
}

variable "env" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
