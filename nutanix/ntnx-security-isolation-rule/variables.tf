# This file is used to declare all variables and default variables if needed

# region provider
variable "prism_user" {}
variable "prism_password" {}
variable "prism_server" {}
variable "prism_port" {}
# endregion

# region nutanix_security_isolation
variable "nutanix_security_isolation_name" {}
variable "nutanix_security_isolation_description" {}
variable "nutanix_security_isolation_rule_action" {}
variable "nutanix_security_isolation_rule_kind_list" {}
variable "nutanix_security_isolation_rule_type" {}
variable "nutanix_security_category_name" {}
variable "nutanix_security_category_values" {}
# endregion
