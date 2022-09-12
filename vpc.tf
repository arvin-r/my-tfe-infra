#Create a custom VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  assign_generated_ipv6_cidr_block = "false"

  tags = merge(
    local.custom_tags,
    {
      type = "network"
      Name = "sandbox-vpc"
    }
  )
}

/* 
output "prod-vpc" {
    value = aws_vpc.prod-vpc
}
 */

#Get list of AZ in the region
data "aws_availability_zones" "available" {
  state = "available"
}

#Create subnets
resource "aws_subnet" "app-subnet" {
  vpc_id = aws_vpc.prod-vpc.id
  count = length(var.app-subnets)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = var.app-subnets[count.index]
  tags = merge(
    local.custom_tags,
    {
      type = "network"
      Name = var.app-subnet-names[count.index]
    }
  )
}

resource "aws_subnet" "web-subnet" {
  vpc_id = aws_vpc.prod-vpc.id
  count = length(var.web-subnets)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = var.web-subnets[count.index]
  tags = merge(
    local.custom_tags,
    {
      type = "network"
      Name = var.web-subnet-names[count.index]
    }
  )
}

resource "aws_subnet" "db-subnet" {
  vpc_id = aws_vpc.prod-vpc.id
  count = length(var.db-subnets)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = var.db-subnets[count.index]
  tags = merge(
    local.custom_tags,
    {
      type = "network"
      Name = var.db-subnet-names[count.index]
    }
  )
}