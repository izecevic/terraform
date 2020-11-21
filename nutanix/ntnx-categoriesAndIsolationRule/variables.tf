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

# region security_isolation
variable "security_isolation" {
    type = object({
    name = string
    description = string
    category = string
    values = list(string)
  })
  default = {
    name = "Finance-to-HR Prod Isolation"
    description = "Isolation Rule between Finance and HR app"
    category = "Isolation"
    values = ["FINANCE-APP","HR-APP"]
  }
}
# endregion