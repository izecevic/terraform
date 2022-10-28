terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#region provider
# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_access_secret
  token = var.aws_token
}
#endregion

#region vpc
# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_main
  tags = { Name = var.vpc_name }
}

#associate additional cidr to the vpc
resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  for_each = toset(var.vpc_cidr_secondary)
  vpc_id     = aws_vpc.main.id
  cidr_block = each.key
  depends_on = [ aws_vpc.main ]
}
#endregion

#region subnets
# Create Public subnet
resource "aws_subnet" "nutanix_public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  tags = { Name = var.public_subnet_name }
  depends_on = [ aws_vpc.main ]
}

# Create private subnet
resource "aws_subnet" "nutanix_private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  tags = { Name = var.private_subnet_name }
  depends_on = [ aws_vpc.main ]
}

# Create User VMs subnets
resource "aws_subnet" "user_vms" {
  for_each = var.user_vm_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr
  tags = { Name = each.key, description = each.value.description }
  depends_on = [ aws_vpc_ipv4_cidr_block_association.secondary_cidr ]
}
#endregion

#region internet and nat gateway
# Create Internet Gateway
resource "aws_internet_gateway" "nutanix_intgw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = var.internet_gateway_name }
}

# EIP for nat_gateway
resource "aws_eip" "nat_gateway" {
  vpc = true
  tags = { Name = var.nat_eip_name }
}

# Create Nat Gateway
resource "aws_nat_gateway" "nutanix_natgw" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.nutanix_public.id
  connectivity_type = "public"
  tags = { Name = var.nat_gateway_name }
}
#endregion

#region route tables
# route table public subnet
resource "aws_route_table" "nutanix_public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.route_default
    gateway_id = aws_internet_gateway.nutanix_intgw.id
  }
  tags = { Name = var.route_subnet_public_name }
}

# route table private subnet
resource "aws_route_table" "nutanix_private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.route_default
    gateway_id = aws_nat_gateway.nutanix_natgw.id
  }
  tags = { Name = var.route_subnet_private_name }
}
#endregion

#region route table association
# Public subnet route_table_association
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.nutanix_public.id
  route_table_id = aws_route_table.nutanix_public.id
}

# Public subnet route_table_association
resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.nutanix_private.id
  route_table_id = aws_route_table.nutanix_private.id
}

# Public subnet route_table_association
resource "aws_route_table_association" "user_vms" {
  for_each = aws_subnet.user_vms
  subnet_id = each.value.id
  route_table_id = aws_route_table.nutanix_private.id
}
#endregion