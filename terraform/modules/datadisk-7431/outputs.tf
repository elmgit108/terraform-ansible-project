output "linux_disk_names" {
  value = [for d in azurerm_managed_disk.linux_disk : d.name]
}
