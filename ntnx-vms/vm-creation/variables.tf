# region authentication
    variable "prismUser" {
        default = "admin"
    }
    variable "prismSecret" {
        default = "YOUR_PASSWORD"
    }
    variable "prismEndpoint" {
        default = "192.168.10.34"
    }
    variable "prismPort" {
        default = "9440"
        }
# endregion

#region cluster information
    variable nutanix_image {
        default = "CentOS_7_Cloud"
    }
    variable nutanix_network {}
#endregion

#region vm configuration
    variable "vm-config" {
        type = object({
            count = string
            cpu = string
            ram  = string
            datadiskSizeMib = number    
        })
        default = {
            count = "1"
            cpu = "1"
            ram = "2048"
            datadiskSizeMib = 51200
        }
    }
#endregion

#region vm customization
    variable "vm-customization" {
    type = object({
        vmname = string
        ips = list(string)
        domain  = string
        subnetmMask = string
        gateway = string
        dns = list(string)
        publicKey = string
    })
    default = {
        vmname = "myvm"
        ips = [""]
        domain  = ""
        subnetmMask = ""
        gateway = ""
        dns = [""]
        publicKey = ""
    }
}
#endregion