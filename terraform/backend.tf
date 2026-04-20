terraform {
  backend "azurerm" {
    resource_group_name  = "tfstateN01017431RG"
    storage_account_name = "tfstaten01017431sa"
    container_name       = "tfstatefiles"
    key                  = "project.terraform.tfstate"
  }
}
