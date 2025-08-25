data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


locals {
    name_prefix = "obs-eks"

    vpc_cidr = "10.0.0.0/16"

    public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
    private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
}
##
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



resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
    tags = {
        Name = "${local.name_prefix}-igw"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id
    tags = {
        Name = "${local.name_prefix}-public-rtb"
    }
}

resource "aws_route" "public_default" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_1" {
    subnet_id = aws_subnet.public_1.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
    subnet_id = aws_subnet.public_2.id
    route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
    domain = "vpc"
    tags = {
        Name = "${local.name_prefix}-nat-eip"
    }
}

resource "aws_nat_gateway" "this" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public_1.id
    depends_on = [ aws_internet_gateway.this ]
    tags = {
        Name = "${local.name_prefix}-nat"
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.this.id
    tags = {
        Name = "${local.name_prefix}-private-rtb"
    }
}

resource "aws_route" "private_default" {
    route_table_id = aws_route_table.private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "private_1" {
    subnet_id = aws_subnet.private_1.id
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
    subnet_id = aws_subnet.private_2.id
    route_table_id = aws_route_table.private.id
}