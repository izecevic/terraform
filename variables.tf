# region authentication
variable "prismUser" {
  default = "admin"
}

variable "prismSecret" {
  default = "4u/Nutanix"
}

variable "prismEndpoint" {
  default = "192.168.10.32"
}

variable "prismPort" {
  default = "9440"
}
# endregion

# region network
variable "networks" {
  type = list
  default = [
    {
      name   = "VLAN_PROD"
      id     = "100"
      bridge = "br0"
    },
    {
      name   = "VLAN_DEV"
      id     = "200"
      bridge = "br1"
    }
  ]
}
#end region