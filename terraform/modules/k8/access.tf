# One access entry per principal
resource "aws_eks_access_entry" "admins" {
  for_each     = toset(var.admin_principals)
  cluster_name = aws_eks_cluster.this.name
  principal_arn = each.value
  # type defaults to "STANDARD" (good)
}

# Attach the AmazonEKSClusterAdminPolicy to each entry, cluster scope
resource "aws_eks_access_policy_association" "admins_cluster_admin" {
  for_each       = aws_eks_access_entry.admins
  cluster_name   = aws_eks_cluster.this.name
  principal_arn  = each.value.principal_arn
  policy_arn     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.admins]
}
