output "windows_vm_names" {
  value = azurerm_windows_virtual_machine.win_vm[*].name
}

output "windows_fqdns" {
  value = azurerm_public_ip.win_pip[*].fqdn
}

output "windows_private_ips" {
  value = azurerm_network_interface.win_nic[*].private_ip_address
}

output "windows_public_ips" {
  value = azurerm_public_ip.win_pip[*].ip_address
}

output "windows_availability_set_name" {
  value = azurerm_availability_set.win_avs.name
}

output "windows_vm_ids" {
  value = azurerm_windows_virtual_machine.win_vm[*].id
}
