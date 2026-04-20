# Required providers block
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.58.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
  required_version = "~> 1.14.3"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # subscription_id is read from the ARM_SUBSCRIPTION_ID environment variable
}
