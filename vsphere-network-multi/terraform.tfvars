# terraforms.tfvars
vsphere_user = "terraform@vsphere.local"
vsphere_password = "Esgi2020!"
vsphere_server = "192.168.10.2"
vsphere_datacenter = "vNested"
vsphere_esxi_name = "192.168.12.53"
vswitch_name = "vSwitch0"
#vsphere_portgroup_name = "PROD"
#vsphere_portgroup_id = 45
vsphere_portgroups = {
  "TEST" = "10"
  "DEV" = "20"
  "PROD" = "30"
}