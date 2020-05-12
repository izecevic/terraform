# Create a Nutanix Flow Isolation policy between 2 Categories
# Categories must be created
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

# creation of the network isolation policy
resource "nutanix_network_security_rule" "isolation" {
    name        = var.security_isolation.name
    description = var.security_isolation.description

    isolation_rule_action = "APPLY"

    isolation_rule_first_entity_filter_kind_list = ["vm"]
    isolation_rule_first_entity_filter_type      = "CATEGORIES_MATCH_ALL"
    isolation_rule_first_entity_filter_params {
        name   = var.security_isolation.first_entity_name
        values = [var.security_isolation.first_entity_value]
    }

    isolation_rule_second_entity_filter_kind_list = ["vm"]
    isolation_rule_second_entity_filter_type      = "CATEGORIES_MATCH_ALL"
    isolation_rule_second_entity_filter_params {
        name   = var.security_isolation.second_entity_name
        values = [var.security_isolation.second_entity_value]
    }
}