# Create 2 Categories
# Create a Nutanix Flow Isolation rule using the 2 created categories
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

# resource category key
resource "nutanix_category_key" "key" {
    name = var.security_isolation.category
    description = "${var.security_isolation.category} category"
}

# resource first value
resource "nutanix_category_value" "first-value" {
    name = nutanix_category_key.key.id
    value = var.security_isolation.values[0]
}

# resource second value
resource "nutanix_category_value" "second-value" {
    name = nutanix_category_key.key.id
    value = var.security_isolation.values[1]
}

# creation of the network isolation policy
resource "nutanix_network_security_rule" "isolation" {
    name        = var.security_isolation.name
    description = var.security_isolation.description

    isolation_rule_action = "APPLY"

    isolation_rule_first_entity_filter_kind_list = ["vm"]
    isolation_rule_first_entity_filter_type      = "CATEGORIES_MATCH_ALL"
    isolation_rule_first_entity_filter_params {
        name   = nutanix_category_key.key.name
        values = [nutanix_category_value.first-value.value]
    }

    isolation_rule_second_entity_filter_kind_list = ["vm"]
    isolation_rule_second_entity_filter_type      = "CATEGORIES_MATCH_ALL"
    isolation_rule_second_entity_filter_params {
        name   = nutanix_category_key.key.name
        values = [nutanix_category_value.second-value.value]
    }
}
