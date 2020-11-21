# Provider
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

# Datasources 
# datasource datacenter
data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

# datasource datastore
data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# datasource resources pool
data "vsphere_resource_pool" "pool" {
  name          = "${var.vsphere_esxi_name}/Resources"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# datasource network
data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# Resources vm
resource "vsphere_virtual_machine" "vm" {
  count            = var.vm_count
  name             = "${var.vm_name}-${count.index + 1}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_cpu
  memory   = var.vm_memory
  guest_id = var.vm_guest_id
  wait_for_guest_net_timeout = 0

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = var.vm_disk_label
    size  = var.vm_disk_size
  }
}