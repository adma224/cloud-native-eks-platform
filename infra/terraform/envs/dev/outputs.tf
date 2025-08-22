output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "hello_world_url" {
  description = "Open http://<this-hostname>/ to see Apache"
  value       = module.k8s.hello_world_hostname
}
