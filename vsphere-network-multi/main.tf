# Provider
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

# Datasources 
data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_host" "host" {
  name           = var.vsphere_esxi_name
  datacenter_id  = data.vsphere_datacenter.datacenter.id
}

# Resource
resource "vsphere_host_port_group" "portgroups" {
  for_each            = var.vsphere_portgroups
  name                = each.key
  host_system_id      = data.vsphere_host.host.id 
  virtual_switch_name = var.vswitch_name 
  vlan_id             = each.value
}