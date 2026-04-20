resource "null_resource" "linux_hostname" {
  for_each = azurerm_linux_virtual_machine.linux_vm

  depends_on = [azurerm_linux_virtual_machine.linux_vm]

  connection {
    type        = "ssh"
    host        = azurerm_public_ip.linux_pip[each.key].ip_address
    user        = var.admin_username
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = ["hostname"]
  }
}
