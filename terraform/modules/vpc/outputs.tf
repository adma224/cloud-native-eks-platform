output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

output "public_route_table_id"  { value = aws_route_table.public.id }
output "private_route_table_id" { value = aws_route_table.private.id }
output "nat_gateway_id"         { value = aws_nat_gateway.this.id }
