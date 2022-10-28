# provider
aws_region  = "eu-west-2" # London
aws_access_key = "my_aws_access_key"
aws_access_secret = "my_aws_secret"
aws_token = "my_aws_token"
#endregion

#region vpc
vpc_name = "nutanix-vpc"
vpc_cidr_main = "10.1.0.0/21"
vpc_cidr_secondary = ["10.3.0.0/21","10.200.0.0/22"] #additional cidrs
#endregion

#region subnets
public_subnet_name = "NC2_public"
public_subnet_cidr = "10.200.0.0/24"
private_subnet_name = "NC2_private"
private_subnet_cidr = "10.200.1.0/24"
user_vm_subnets = { 
    WEB = { cidr = "10.3.0.0/24", description = "Prod_WEB"},
    APP = { cidr = "10.3.1.0/24", description = "Prod_APP"},
    DB = { cidr = "10.3.2.0/24", description = "Prod_DB"}
}
#endregion

#region internet and nat gateway
internet_gateway_name = "NC2_internet_gw"
nat_gateway_name = "NC2_nat_gw"
nat_eip_name = "NC2_eip"
#endregion

#region route tables
route_default = "0.0.0.0/0"
route_subnet_public_name = "NC2_public_route"
route_subnet_private_name = "NC2_private_route"
#endregion