# terraforms.tfvars

# Providers
vsphere_user = "terraform@vsphere.local"
vsphere_password = "YOUR_PASSWORD"
vsphere_server = "192.168.10.2"

# Infrastructure
vsphere_datacenter = "vNested"
vsphere_datastore = "myDatastore"
vsphere_cluster_name = "myCluster" 
vsphere_esxi_name = "192.168.12.53"
vsphere_network = "myPortgroup"

# VM
vm_count = "2"
vm_name = "vm-test"
vm_cpu = "1"
vm_memory = "256"
vm_guest_id = "otherGuest64"
vm_disk_label = "disk0"
vm_disk_size = "1"