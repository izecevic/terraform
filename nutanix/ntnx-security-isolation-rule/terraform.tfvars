# This file is used to fill all our custom variables (non-default)

# provider
#prism_user = "" #using export TF_VAR_prism_user = "MyPrismUser"
#prism_password = "" #using export TF_VAR_prism_password = "MyPrismPwd"
#prism_server = "" #using export TF_VAR_prism_server = "MyPrismServer"
prism_port = "9440"
#endregion

# nutanix security isolation rules
nutanix_security_isolation_name = "IZ Isolation Rule" #name of the isolation rule
nutanix_security_isolation_description = "Isolate IZ Apps Prod from Dev" # description of the isolation rule
nutanix_security_isolation_rule_kind_list = "vm"
nutanix_security_isolation_rule_type = "CATEGORIES_MATCH_ALL"
nutanix_security_isolation_rule_action = "MONITOR" #APPLY, MONITOR
nutanix_security_category_name = "Environment" # Category name
nutanix_security_category_values = ["Dev","Production"] #Category values
#endregion