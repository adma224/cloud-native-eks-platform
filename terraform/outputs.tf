output "account_id" {
  description = "AWS account ID used by this run"
  value       = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  description = "Caller ARN (role/user)"
  value       = data.aws_caller_identity.current.arn
}

output "region" {
  description = "AWS region"
  value       = data.aws_region.current.name
}

output "tags_preview" {
  description = "Default tags that will apply to future resources"
  value = {
    project = var.project
    env     = var.env
  }
}


output "vpc_id" {
  description = "VPC ID"
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "Public route table ID"
}