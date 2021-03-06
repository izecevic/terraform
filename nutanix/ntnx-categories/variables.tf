# region authentication
variable "prismUser" {
  default = "admin"
}

variable "prismSecret" {
  default = "password"
}

variable "prismEndpoint" {
  default = "192.168.10.34"
}

variable "prismPort" {
  default = "9440"
}
# endregion

# region category
variable "category" {
  type = list(string)
  default = ["Finance-App","HR-APP","Training-APP"]
}
# endregion