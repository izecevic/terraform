# provider and authentication
provider "nutanix" {
  username = var.prism_user
  password = var.prism_password
  endpoint = var.prism_server
  port     = var.prism_port
  insecure = true

}

# resource network
resource "nutanix_subnet" "networks" {
  for_each = var.prism_subnets
  cluster_uuid = local.cluster
  subnet_type  = "VLAN"
  name         = "my-network"
  vlan_id      = 10
}
