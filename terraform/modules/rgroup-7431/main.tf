resource "azurerm_resource_group" "rgroup" {
  name     = var.rg_name
  location = var.location
  tags     = local.tags
}
