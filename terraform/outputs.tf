output "account_id" { value = data.aws_caller_identity.current.account_id }
output "caller_arn" { value = data.aws_caller_identity.current.arn }
output "region"     { value = data.aws_region.current.name }

# Pass-throughs from the VPC module
output "vpc_id"             { value = module.vpc.vpc_id }
output "public_subnet_ids"  { value = module.vpc.public_subnet_ids }
output "private_subnet_ids" { value = module.vpc.private_subnet_ids }

output "cluster_name" {
  value = module.k8.cluster_name
}

output "cluster_endpoint" {
  value = module.k8.cluster_endpoint
}

output "cluster_oidc_url" {
  value = module.k8.oidc_issuer_url
}


# Handy: drop-in kubeconfig that uses AWS CLI token exec
# Save it with: terraform -chdir=terraform output -raw kubeconfig_yaml > kubeconfig.yaml
output "kubeconfig_yaml" {
  value = <<-EOT
apiVersion: v1
clusters:
- cluster:
    server: ${module.k8.cluster_endpoint}
    certificate-authority-data: ${module.k8.cluster_ca_data}
  name: ${module.k8.cluster_name}
contexts:
- context:
    cluster: ${module.k8.cluster_name}
    user: ${module.k8.cluster_name}
  name: ${module.k8.cluster_name}
current-context: ${module.k8.cluster_name}
kind: Config
preferences: {}
users:
- name: ${module.k8.cluster_name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: aws
      args:
        - eks
        - get-token
        - --region
        - ${data.aws_region.current.name}
        - --cluster-name
        - ${module.k8.cluster_name}
  EOT
}