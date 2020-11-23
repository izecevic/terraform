# provider and authentication
provider "nutanix" {
    username = var.prism_user
    password = var.prism_password
    endpoint = var.prism_server
    port     = var.prism_port
    insecure = true
}

#region datasources
data "nutanix_clusters" "clusters" {}
locals {
    cluster = data.nutanix_clusters.clusters.entities[0].metadata.uuid
}
data "nutanix_cluster" "cluster" {
    cluster_id = local.cluster
}
data "nutanix_subnet" "network" {
    subnet_name = var.nutanix_network
}
data "nutanix_image" "image" {
    image_name = var.nutanix_image
}
data "template_file" "cloud" {
    count = var.vm_count
    template = file("cloud-init")
    vars = {
        vm_user = var.vm_user
        vm_name = "${var.vm_name}-${count.index + 1}"
        vm_ip = "${var.vm_ipv4_add_base}.${var.vm_ipv4_add_last_octet + (count.index + 1)}"
        vm_domain = var.vm_domain
        vm_netmask = var.vm_ipv4_netmask
        vm_gateway = var.vm_ipv4_gateway
        vm_dns1 = var.vm_dns1
        vm_dns2 = var.vm_dns2
        vm_public_key = var.vm_public_key
    }
}
#endregion

#region resources
resource "nutanix_virtual_machine" "vm" {
    count                = var.vm_count
    name                 = "${var.vm_name}-${count.index + 1}"
    num_vcpus_per_socket = var.vm_num_vcpus_per_socket
    num_sockets          = var.vm_cpu
    memory_size_mib      = var.vm_ram
    cluster_uuid         = data.nutanix_cluster.cluster.id
    
    guest_customization_cloud_init_user_data = base64encode("${element(data.template_file.cloud.*.rendered,count.index)}")

    nic_list {
        subnet_uuid = data.nutanix_subnet.network.id
    }

    disk_list {
        data_source_reference = {
            kind = var.nutanix_image_source_reference 
            uuid = data.nutanix_image.image.id
        }
    }

    disk_list {
        device_properties {
            disk_address = {
                device_index = var.vm_disk_devide_index
                adapter_type = var.vm_disk_adapter_type 
            }
            device_type = var.vm_disk_type
        }
        disk_size_mib   = (var.vm_disk_size_gb * 1024)
    }
}
#endregion