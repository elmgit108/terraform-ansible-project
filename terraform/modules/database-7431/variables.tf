variable "resource_group_name" {
  type    = string
  default = "7431RG"
}

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "db_server_name" {
  type    = string
  default = "psql-7431"
}

variable "db_admin_username" {
  type    = string
  default = "psqladmin7431"
}

variable "db_admin_password" {
  type      = string
  sensitive = true
}
