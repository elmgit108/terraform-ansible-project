# Resource Group
output "resource_group_name" {
  value = module.rgroup.rg_name
}

# Networking
output "virtual_network_name" {
  value = module.network.vnet_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

# Common Services
output "log_analytics_workspace_name" {
  value = module.common.law_name
}

output "recovery_services_vault_name" {
  value = module.common.vault_name
}

output "storage_account_name" {
  value = module.common.storage_account_name
}

# Linux VMs
output "linux_vm_hostnames" {
  value = module.vmlinux.linux_vm_names
}

output "linux_vm_fqdns" {
  value = module.vmlinux.linux_fqdns
}

output "linux_vm_private_ips" {
  value = module.vmlinux.linux_private_ips
}

output "linux_vm_public_ips" {
  value = module.vmlinux.linux_public_ips
}

output "linux_availability_set_name" {
  value = module.vmlinux.linux_availability_set_name
}

# Windows VM
output "windows_vm_hostnames" {
  value = module.vmwindows.windows_vm_names
}

output "windows_vm_fqdns" {
  value = module.vmwindows.windows_fqdns
}

output "windows_vm_private_ips" {
  value = module.vmwindows.windows_private_ips
}

output "windows_vm_public_ips" {
  value = module.vmwindows.windows_public_ips
}

output "windows_availability_set_name" {
  value = module.vmwindows.windows_availability_set_name
}

# Load Balancer
output "load_balancer_name" {
  value = module.loadbalancer.lb_name
}

output "load_balancer_public_ip" {
  value = module.loadbalancer.lb_public_ip
}

output "load_balancer_fqdn" {
  value = module.loadbalancer.lb_fqdn
}

# Database
output "database_server_name" {
  value = module.database.db_server_name
}

output "database_fqdn" {
  value = module.database.db_fqdn
}

# Data Disks
output "linux_data_disk_names" {
  value = module.datadisk.linux_disk_names
}

# Ansible Provisioner
output "ansible_provisioner_id" {
  value       = null_resource.ansible_provisioner.id
  description = "ID of the Ansible provisioner null_resource"
}
