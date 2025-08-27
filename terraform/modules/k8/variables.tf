# Cluster identity
variable "cluster_name"       { type = string }
variable "kubernetes_version" { type = string }

# Networking
variable "vpc_id"             { type = string }
variable "public_subnet_ids"  { type = list(string) }
variable "private_subnet_ids" { type = list(string) }

# Node group sizing
variable "node_instance_type" { type = string }
variable "node_desired_size"  { type = number }
variable "node_min_size"      { type = number }
variable "node_max_size"      { type = number }

variable "admin_principals" { type = list(string) }


