# provider and authentication
provider "nutanix" {
  username = var.prism_user
  password = var.prism_password
  endpoint = var.prism_server
  port     = var.prism_port
  insecure = true

}

# Get PE cluster uuid and assigned to local variable
data "nutanix_clusters" "clusters" {}
locals {
  cluster = data.nutanix_clusters.clusters.entities[0].metadata.uuid
}


# resource network
resource "nutanix_subnet" "networks" {
  for_each = var.prism_subnets
  cluster_uuid = local.cluster
  subnet_type  = var.prism_subnet_type
  name         = var.prism_subnet_name
  vlan_id      = var.prism_subnet_id
}
