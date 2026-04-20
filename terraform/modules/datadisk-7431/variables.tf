variable "resource_group_name" {
  type    = string
  default = "7431RG"
}

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "disk_size_gb" {
  type    = number
  default = 10
}

variable "linux_vm_ids" {
  type        = map(string)
  description = "Map of Linux VM name => VM ID for disk attachment"
}
