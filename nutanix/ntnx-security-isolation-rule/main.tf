# This file is the main code: create a Nutanix FLow Isolation Security Rule

# provider and authentication
provider "nutanix" {
  username = var.prism_user
  password = var.prism_password
  endpoint = var.prism_server
  port     = var.prism_port

  insecure = true
}

# retreive the nutanix security isolation rule
data "nutanix_network_security_rule" "isolation_rule" {
  network_security_rule_id = nutanix_network_security_rule.isolation.id
}

# creation of the network isolation policy
resource "nutanix_network_security_rule" "isolation" {
    name        = var.nutanix_security_isolation_name
    description = var.nutanix_security_isolation_description

    isolation_rule_action = var.nutanix_security_isolation_rule_action

    isolation_rule_first_entity_filter_kind_list = [var.nutanix_security_isolation_rule_kind_list]
    isolation_rule_first_entity_filter_type      = var.nutanix_security_isolation_rule_type
    isolation_rule_first_entity_filter_params {
        name   = var.nutanix_security_category_name
        values = [var.nutanix_security_category_values[0]]
    }

    isolation_rule_second_entity_filter_kind_list = [var.nutanix_security_isolation_rule_kind_list]
    isolation_rule_second_entity_filter_type      = var.nutanix_security_isolation_rule_type
    isolation_rule_second_entity_filter_params {
        name   = var.nutanix_security_category_name
        values = [var.nutanix_security_category_values[1]]
    }
}
