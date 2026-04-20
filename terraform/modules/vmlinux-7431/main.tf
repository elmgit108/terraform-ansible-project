locals {
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "elena.martischuk"
    ExpirationDate = "2026-04-30"
    Environment    = "Project"
  }
}

# Availability Set
resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_avs_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = local.tags
}

# Public IPs - Standard SKU required for Standard Load Balancer
resource "azurerm_public_ip" "linux_pip" {
  for_each            = var.linux_vms
  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "vm-${each.key}"
  tags                = local.tags
}

# Network Interfaces
resource "azurerm_network_interface" "linux_nic" {
  for_each            = var.linux_vms
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[each.key].id
  }
}

# Linux Virtual Machines
resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = var.linux_vms
  name                = each.key
  computer_name       = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = each.value
  availability_set_id = azurerm_availability_set.linux_avs.id
  tags                = local.tags

  network_interface_ids = [azurerm_network_interface.linux_nic[each.key].id]

  admin_username                  = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.linux_publisher
    offer     = var.linux_offer
    sku       = var.linux_sku
    version   = var.linux_version
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }
}

# Network Watcher Extension
resource "azurerm_virtual_machine_extension" "nw_watcher" {
  for_each                   = azurerm_linux_virtual_machine.linux_vm
  name                       = "NetworkWatcherAgentLinux"
  virtual_machine_id         = each.value.id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = local.tags
}

# Azure Monitor Extension
resource "azurerm_virtual_machine_extension" "monitor" {
  for_each                   = azurerm_linux_virtual_machine.linux_vm
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = each.value.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = local.tags

  depends_on = [azurerm_virtual_machine_extension.nw_watcher]
}
