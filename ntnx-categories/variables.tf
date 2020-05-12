# region authentication
variable "prismUser" {
  default = "admin"
}

variable "prismSecret" {
  default = "Samedi18!"
}

variable "prismEndpoint" {
  default = "192.168.10.34"
}

variable "prismPort" {
  default = "9440"
}
# endregion

# region network
variable "category" {
  type = list(string)
  default = ["Finance-App","HR-APP","Training-APP"]
}
# endregion