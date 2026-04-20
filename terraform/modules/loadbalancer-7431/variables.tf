variable "resource_group_name" {
  type    = string
  default = "7431RG"
}

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "lb_name" {
  type    = string
  default = "7431-lb"
}

variable "linux_nic_ids" {
  type        = map(string)
  description = "Map of Linux VM name => NIC ID for backend pool association"
}
