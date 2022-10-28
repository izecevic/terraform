#region provider
variable "aws_region" {}
variable "aws_access_key" {}
variable "aws_access_secret" {}
variable "aws_token" {}
# endregion

#region vpc
variable "vpc_name" {}
variable "vpc_cidr_main" {}
variable "vpc_cidr_secondary" { type = list }
# endregion

#region subnets
variable "public_subnet_name" {}
variable "public_subnet_cidr" {}
variable "private_subnet_name" {}
variable "private_subnet_cidr" {}
variable "user_vm_subnets" {}
#endregion

#region internet and nat gateway
variable "internet_gateway_name" {}
variable "nat_gateway_name" {}
variable "nat_eip_name" {}
#endregion

#region route tables
variable "route_default" {}
variable "route_subnet_public_name" {}
variable "route_subnet_private_name" {}
#endregion
