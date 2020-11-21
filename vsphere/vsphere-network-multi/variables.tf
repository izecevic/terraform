# variables.tf
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_datacenter" {}
variable "vsphere_esxi_name" {}
variable "vswitch_name" {}
variable "vsphere_portgroups" { type=map }
