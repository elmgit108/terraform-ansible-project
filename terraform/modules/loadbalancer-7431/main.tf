locals {
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "elena.martischuk"
    ExpirationDate = "2026-04-30"
    Environment    = "Project"
  }
}

# Public IP for Load Balancer frontend
resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.lb_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "lb-${var.lb_name}-fe"
  tags                = local.tags
}

# Load Balancer
resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = local.tags

  frontend_ip_configuration {
    name                 = "${var.lb_name}-fe-config"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

# Backend Address Pool
resource "azurerm_lb_backend_address_pool" "lb_pool" {
  name            = "${var.lb_name}-backend-pool"
  loadbalancer_id = azurerm_lb.lb.id
}

# Associate Linux NICs with backend pool
resource "azurerm_network_interface_backend_address_pool_association" "lb_nic_assoc" {
  for_each                = var.linux_nic_ids
  network_interface_id    = each.value
  ip_configuration_name   = "${each.key}-ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_pool.id
}

# Health Probe
resource "azurerm_lb_probe" "lb_probe" {
  name            = "${var.lb_name}-http-probe"
  loadbalancer_id = azurerm_lb.lb.id
  port            = 80
}

# LB Rule
resource "azurerm_lb_rule" "lb_rule" {
  name                           = "${var.lb_name}-http-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.lb_name}-fe-config"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_pool.id]
  probe_id                       = azurerm_lb_probe.lb_probe.id
}
