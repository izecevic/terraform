# region authentication
variable "prismUser" {
  default = "admin"
}

variable "prismSecret" {
  default = "enter admin password"
}

variable "prismEndpoint" {
  default = "enter PE IP"
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
    "NET_PROD" = "300"
    "NET_DEV" = "800"
  }
}
# endregion