output "account_id" { value = data.aws_caller_identity.current.account_id }
output "caller_arn" { value = data.aws_caller_identity.current.arn }
output "region"     { value = data.aws_region.current.name }

# Pass-throughs from the VPC module
output "vpc_id"             { value = module.vpc.vpc_id }
output "public_subnet_ids"  { value = module.vpc.public_subnet_ids }
output "private_subnet_ids" { value = module.vpc.private_subnet_ids }
