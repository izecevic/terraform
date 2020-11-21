# variables.tf

# variables provider
variable "vsphere_user" {
  description = "account used for authentication"
  default = "root"
}
variable "vsphere_password" {}
variable "vsphere_server" {}

#variables infra
variable "vsphere_datacenter" {}
variable "vsphere_datastore" {}
variable "vsphere_cluster_name" {}
variable "vsphere_esxi_name" {}
variable "vsphere_network" {}

# variables vm
variable "vm_count" {}
variable "vm_name" {}
variable "vm_cpu" {
  default = 2
}
variable "vm_memory" {
  default = 512
} 
variable "vm_guest_id" {}
variable "vm_disk_label" {}
variable "vm_disk_size" {}