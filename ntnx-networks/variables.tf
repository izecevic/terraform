# region authentication
variable "prismUser" {
  default = "admin"
}

variable "prismSecret" {
  default = "4u/Nutanix!"
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
  type = map
  default = {
    "NET_TEST" = "400"
  }
}
# endregion