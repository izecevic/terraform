# create categories
# variables.tf needs to be filled

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

# resource categories
resource "nutanix_category_key" "key" {
    for_each = toset(var.category)
    name = each.key
    description = "${each.key} category"
}

resource "nutanix_category_value" "value" {
    for_each = toset(var.category)
    name = nutanix_category_key.key[each.key].id
    value = each.key
}