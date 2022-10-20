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
  access_key = "ASIAWRBYLUVQDG4ZSS3D"
  secret_key = "bSY5Llk8fWEN7iZuiMruSL3YTqYqsphOiRmSh4ON"
  token = "IQoJb3JpZ2luX2VjEIX//////////wEaCXVzLXdlc3QtMiJHMEUCIQDHDLwIirnehANvBlFe6BzzvZTwfJH/cFe2am3qwwj1dgIgVZI1a0auoUMdVncLhHW4//a1AZOcjGO6xHOs1IvxjM8qrAMIXhADGgw0NDg5NDIyODYxNzYiDOG074y/e7v4zYRxciqJAynglMm71DmPLZBa3vicUFqjyHL8XSR6tZPkRsWX6X9+ZAgJDHlY7Hk6QK837NcFQykJMXRE2nSqWtm9mP5fKg/PPexo9+PnBm54pF1hweZbE55Up359Q3tjUxaN0jqbThr4t3z0VWZ+QlPQQBd9wssmiMR7DA3PLKVC3PH45j4pjJRhZEfpqw/QtFkMhImpmu20wnYAUPZcKF0pQ5304ypJ+mAHUy3tBnhTo7YqIsOx/jPKjfqbFci2d16vWDXdCxQXcCSWQ7uLDm0SRD3AjqUQ14xIdWSvEBAG08WEXNxPZ3u8ISoKf4LHNhBIF96Le+saN/oIalcsjdCe2GFz2tVqNepCGV3CsRqRqbC7/ksytpvYDpNvvXeaEMFyLRUfUf9CkR2TA/WpEkF7+nnlYsLHLTCJ20xqxI/M7psPVrFta1RV7OckoHor6Ki/s/U5xJAmPPT3IQaxnJjeYkPzknADIsQGKqLqebyXg5JEJP8Hdrc4Lv+0mSmgbMfTpxqHU1QBrOyBGsyBmDC3jMWaBjqmASfZzQzzyIbmH7srzFdRMtphB3phxf/r9csJzT3s1/uC6vTjrlraE2p3IrqH4zfjboUcMAUhq5ID5ybGX72F4oWoo2+untd85prB1NRfB85wjOUukNxdJQLNS9+TBLeF5IwRGx+5paWMwny5MP7ZbTO8N07GgPUe/kyDcoHqey03ELJLeegGNjoM5CHng52P5G//svM4LeYxA1NQmBW72GqULvvb/E8="
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
