locals {
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "elena.martischuk"
    ExpirationDate = "2026-04-30"
    Environment    = "Project"
  }
}

variable "rg_name" {
  type    = string
  default = "7431RG"
}

variable "location" {
  type    = string
  default = "Canada Central"
}
