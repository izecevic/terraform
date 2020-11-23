# provider
prism_user = "iz@emeagso.lab"
prism_password = "YOUR_PASSWORD"
prism_server = "YOUR_PE_SERVER"
prism_port = "9440"

# nutanix image and infra
nutanix_image = "CentOS7-MoE"
nutanix_image_source_reference = "image"
nutanix_network = "VLAN98"
#endregion

# region nutanix vm config
vm_count = 3 
vm_name = "dev-vm"
vm_num_vcpus_per_socket = 1
vm_cpu = 1
vm_ram = 1024
vm_disk_type = "DISK"
vm_disk_devide_index = 1
vm_disk_adapter_type = "SCSI"
vm_disk_size_gb = 20
#endregion

# nutanix vm cuustomization
vm_ipv4_add_base = "10.68.98"
vm_ipv4_add_last_octet = 90
vm_ipv4_netmask = "255.255.255.0"
vm_ipv4_gateway = "10.68.98.1"
vm_domain = "emeagso.lab"
vm_dns1 = "10.68.97.4" 
vm_dns2 = "10.68.97.5"
vm_user = "centos"
vm_public_key = "centos ssh_public_key XXXXXXXXX"