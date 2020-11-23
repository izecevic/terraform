# region authentication
variable "prism_user" {}
variable "prism_password" {}
variable "prism_server" {}
variable "prism_port" {}
# endregion

#region cluster information
variable "nutanix_image" {}
variable "nutanix_network" {}
variable "nutanix_image_source_reference" {}
#endregion

#region vm config
variable "vm_count" {}
variable "vm_name" {}
variable "vm_num_vcpus_per_socket" {}
variable "vm_cpu" {}
variable "vm_ram" {}
variable "vm_disk_type" {}
variable "vm_disk_devide_index" {}
variable "vm_disk_adapter_type" {}
variable "vm_disk_size_gb" {}
#endregion

#region vm customization
variable "vm_user" {}
variable "vm_ipv4_add_base" {}
variable "vm_ipv4_add_last_octet" {}
variable "vm_ipv4_netmask" {}
variable "vm_ipv4_gateway" {}
variable "vm_domain" {}
variable "vm_dns1" {}
variable "vm_dns2" {}
variable "vm_public_key" {}
#endregion