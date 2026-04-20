variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Password for the Windows VM administrator. Set via TF_VAR_admin_password."
}

variable "db_admin_password" {
  type        = string
  sensitive   = true
  description = "Password for the PostgreSQL administrator. Set via TF_VAR_db_admin_password."
}
