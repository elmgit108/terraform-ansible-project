variable "resource_group_name" {
  type    = string
  default = "7431RG"
}

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "vnet_name" {
  type    = string
  default = "7431-VNET"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  type    = string
  default = "7431-SUBNET"
}

variable "subnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}

variable "nsg_name" {
  type    = string
  default = "7431-NSG"
}
