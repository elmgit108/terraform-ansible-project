locals {
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "elena.martischuk"
    ExpirationDate = "2026-04-30"
    Environment    = "Project"
  }
}

# Managed disks for Linux VMs
resource "azurerm_managed_disk" "linux_disk" {
  for_each             = var.linux_vm_ids
  name                 = "${each.key}-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
  tags                 = local.tags
}

# Attach data disks to Linux VMs
resource "azurerm_virtual_machine_data_disk_attachment" "linux_attach" {
  for_each           = var.linux_vm_ids
  managed_disk_id    = azurerm_managed_disk.linux_disk[each.key].id
  virtual_machine_id = each.value
  lun                = 0
  caching            = "ReadWrite"
}
