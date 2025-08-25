data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


locals {
    name_prefix = "obs-eks"

    vpc_cidr = "10.0.0.0/16"

    public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
    private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
}

data "aws_availability_zones" "available" {
    state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}
##
resource "aws_vpc" "this" {
    cidr_block = local.vpc_cidr

    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "${local.name_prefix}-vpc"
    }
}  

resource "aws_subnet" "public_1" {
    vpc_id = aws_vpc.this.id
    cidr_block = local.public_subnet_cidrs[0]
    availability_zone = local.azs[0]
    map_public_ip_on_launch = true

    tags = {
        Name = "${local.name_prefix}-public-1"
    }
}

resource "aws_subnet" "public_2" {
    vpc_id = aws_vpc.this.id
    cidr_block = local.public_subnet_cidrs[1]
    availability_zone = local.azs[1]
    map_public_ip_on_launch = true
    tags = {
        Name = "${local.name_prefix}-public-2"
    }   
}

resource "aws_subnet" "private_1" {
    vpc_id = aws_vpc.this.id
    cidr_block = local.private_subnet_cidrs[0]
    availability_zone = local.azs[0]
    tags = {
        Name = "${local.name_prefix}-private-1"
    }   
}

resource "aws_subnet" "private_2" {
    vpc_id = aws_vpc.this.id
    cidr_block = local.private_subnet_cidrs[1]
    availability_zone = local.azs[1]
    tags = {
        Name = "${local.name_prefix}-private-2"
    }   
}

#