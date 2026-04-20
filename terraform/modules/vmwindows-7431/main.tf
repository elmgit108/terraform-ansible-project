locals {
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "elena.martischuk"
    ExpirationDate = "2026-04-30"
    Environment    = "Project"
  }
}

# Availability Set
resource "azurerm_availability_set" "win_avs" {
  name                         = var.win_avs_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = local.tags
}

# Public IPs
resource "azurerm_public_ip" "win_pip" {
  count               = var.windows_count
  name                = "${var.win_vm_name}-${count.index + 1}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "vm-${var.win_vm_name}-${count.index + 1}"
  tags                = local.tags
}

# Network Interfaces
resource "azurerm_network_interface" "win_nic" {
  count               = var.windows_count
  name                = "${var.win_vm_name}-${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  ip_configuration {
    name                          = "${var.win_vm_name}-${count.index + 1}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win_pip[count.index].id
  }
}

# Windows Virtual Machines
resource "azurerm_windows_virtual_machine" "win_vm" {
  count               = var.windows_count
  name                = "${var.win_vm_name}-${count.index + 1}"
  computer_name       = "7431-win-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.win_vm_size
  availability_set_id = azurerm_availability_set.win_avs.id
  tags                = local.tags

  network_interface_ids = [azurerm_network_interface.win_nic[count.index].id]

  admin_username = var.admin_username
  admin_password = var.admin_password

  os_disk {
    name                 = "${var.win_vm_name}-${count.index + 1}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.win_publisher
    offer     = var.win_offer
    sku       = var.win_sku
    version   = var.win_version
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  winrm_listener {
    protocol = "Http"
  }
}

# Antimalware Extension
resource "azurerm_virtual_machine_extension" "antimalware" {
  count                      = var.windows_count
  name                       = "Antimalware"
  virtual_machine_id         = azurerm_windows_virtual_machine.win_vm[count.index].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.5"
  auto_upgrade_minor_version = true
  tags                       = local.tags

  settings = jsonencode({
    AntimalwareEnabled        = true
    RealtimeProtectionEnabled = "true"
    ScheduledScanSettings = {
      isEnabled = "false"
      day       = "7"
      time      = "120"
      scanType  = "Quick"
    }
    Exclusions = {
      Extensions = ""
      Paths      = ""
      Processes  = ""
    }
  })
}
