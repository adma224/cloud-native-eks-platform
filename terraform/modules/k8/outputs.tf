output "cluster_name"    { value = aws_eks_cluster.this.name }
output "cluster_arn"     { value = aws_eks_cluster.this.arn }
output "cluster_version" { value = aws_eks_cluster.this.version }
output "cluster_endpoint"{ value = aws_eks_cluster.this.endpoint }
output "nodegroup_name" { value = aws_eks_node_group.default.node_group_name }
output "node_role_arn"  { value = aws_iam_role.node.arn }
