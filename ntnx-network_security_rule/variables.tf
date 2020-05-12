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
variable "security_isolation" {
    type = object({
    name = string
    description = string
    first_entity_name = string
    first_entity_value = string
    second_entity_name = string
    second_entity_value = string
  })
  default = {
    name = "igor-isolation-rule"
    description = "Igor Isolation Rule Example"
    first_entity_name = "Environment"
    first_entity_value = "Dev"
    second_entity_name = "Environment"
    second_entity_value = "Production"
  }
}
# endregion