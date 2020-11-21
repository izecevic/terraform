# region authentication
variable "prism_user" {}
variable "prism_password" {}
variable "prism_server" {}
variable "prism_port" {}
# endregion

# region network
variable "prism_subnets" { type = map }
variable "prism_subnet_type" {}
# endregion