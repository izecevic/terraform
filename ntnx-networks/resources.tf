# provider and authentication
provider "nutanix" {
  username = var.prismUser
  password = var.prismSecret
  endpoint = var.prismEndpoint
  insecure = true
  port     = var.prismPort
}

# get PE cluster uuid and assigned to local variable
data "nutanix_clusters" "clusters" {}
locals {
  cluster = data.nutanix_clusters.clusters.entities[0].metadata.uuid
}

# resource network
resource "nutanix_subnet" "networks" {
  for_each = var.networks
  cluster_uuid = local.cluster
  subnet_type  = "VLAN"
  name         = each.key
  vlan_id      = each.value
}
