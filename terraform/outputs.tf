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
