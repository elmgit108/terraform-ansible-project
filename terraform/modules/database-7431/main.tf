locals {
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "elena.martischuk"
    ExpirationDate = "2026-04-30"
    Environment    = "Project"
  }
}

# PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "db" {
  name                          = var.db_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "16"
  sku_name                      = "B_Standard_B1ms"
  storage_mb                    = 32768
  storage_tier                  = "P4"
  administrator_login           = var.db_admin_username
  administrator_password        = var.db_admin_password
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  public_network_access_enabled = true
  lifecycle {
    ignore_changes = [
      zone,
      high_availability.0.standby_availability_zone
    ]
  }

  tags = local.tags
}
