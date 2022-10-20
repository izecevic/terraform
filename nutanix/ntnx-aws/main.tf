terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-3"
  access_key = "XXX"
  secret_key = "XXX"
  token = "XXX"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "nutanix_vpc_mara" }
}

#associate additional cidr to the vpc
# resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
#  vpc_id     = aws_vpc.main.id
#  cidr_block = "10.3.0.0/21"
# }

# Create Public subnet
resource "aws_subnet" "nutanix_public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags = { Name = "Nutanix_Public" }
}

# Create Management subnet
resource "aws_subnet" "nutanix_management" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  tags = { Name = "Nutanix_Management" }
}

# Create Internet Gateway
resource "aws_internet_gateway" "nutanix_intgw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "Nutanix_Internet_GW" }
}

# EIP for nat_gateway
resource "aws_eip" "nat_gateway" {
  vpc = true
  tags = { Name = "Nutanix_NAT_EIP" }
}

# Create Nat Gateway
resource "aws_nat_gateway" "nutanix_natgw" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.nutanix_public.id
  connectivity_type = "public"
  tags = { Name = "Nutanix_NAT_GW" }
}


# route table public subnet
resource "aws_route_table" "nutanix_public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nutanix_intgw.id
  }
  tags = { Name = "Nutanix_RT_Public" }
}

# Public subnet route_table_association
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.nutanix_public.id
  route_table_id = aws_route_table.nutanix_public.id
}

# route table management subnet
resource "aws_route_table" "nutanix_management" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nutanix_natgw.id
  }
  tags = { Name = "Nutanix_RT_Management" }
}

# Public subnet route_table_association
resource "aws_route_table_association" "management" {
  subnet_id = aws_subnet.nutanix_management.id
  route_table_id = aws_route_table.nutanix_management.id
}
