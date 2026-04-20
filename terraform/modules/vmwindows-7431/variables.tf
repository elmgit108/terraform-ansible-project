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

variable "win_avs_name" {
  type    = string
  default = "7431-win-avs"
}

variable "win_vm_name" {
  type    = string
  default = "7431-win-vm"
}

variable "windows_count" {
  type    = number
  default = 1
}

variable "win_vm_size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "admin_username" {
  type    = string
  default = "n01017431"
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "win_publisher" {
  type    = string
  default = "MicrosoftWindowsServer"
}

variable "win_offer" {
  type    = string
  default = "WindowsServer"
}

variable "win_sku" {
  type    = string
  default = "2016-Datacenter"
}

variable "win_version" {
  type    = string
  default = "latest"
}
