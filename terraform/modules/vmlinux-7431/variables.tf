variable "resource_group_name" {
  type    = string
  default = "7431RG"
}

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "subnet_id" {
  type = string
}

variable "storage_account_uri" {
  type = string
}

variable "linux_avs_name" {
  type    = string
  default = "7431-linux-avs"
}

variable "linux_vms" {
  type = map(string)
  default = {
    "7431-linux-vm-1" = "Standard_D2s_v3"
    "7431-linux-vm-2" = "Standard_D2s_v3"
    "7431-linux-vm-3" = "Standard_D2s_v3"
  }
}

variable "admin_username" {
  type    = string
  default = "n01017431"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "linux_publisher" {
  type    = string
  default = "OpenLogic"
}

variable "linux_offer" {
  type    = string
  default = "CentOS"
}

variable "linux_sku" {
  type    = string
  default = "8_2"
}

variable "linux_version" {
  type    = string
  default = "latest"
}
