output "law_name" {
  value = azurerm_log_analytics_workspace.law.name
}

output "vault_name" {
  value = azurerm_recovery_services_vault.vault.name
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "storage_account_primary_blob_endpoint" {
  value = azurerm_storage_account.sa.primary_blob_endpoint
}
