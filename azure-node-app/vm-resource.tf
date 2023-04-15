# generate random password

resource "random_password" "vm-password" {
  length    = 16
  min_upper = 5
  min_lower = 5
  numeric    = true
  special   = true
}

# generate random vm-name

resource "random_string" "vm-name" {
  length  = 8
  upper   = false
  numeric = false
  lower   = true
  special = false
}


# create linux vm

resource "azurerm_linux_virtual_machine" "node-app-vm" {
  depends_on = [
    azurerm_network_interface.node-app-nic
  ]

  name                  = "node-app-vm"
  location              = azurerm_resource_group.node-app-group.location
  resource_group_name   = azurerm_resource_group.node-app-group.name
  network_interface_ids = [azurerm_network_interface.node-app-nic.id]
  size                  = var.linux_vm_size

  source_image_reference {
    publisher = var.linux_vm_image_publisher
    offer     = var.linux_vm_image_offer
    sku       = var.centos_8_sku
    version   = "latest"
  }

  os_disk {
    name                 = "linux-vm-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name  = "node-app-vm"
  admin_username = var.linux_admin_username
  admin_password = var.linux_admin_password
  custom_data    = base64encode(data.template_file.vm_cloud_init_script.rendered)
  disable_password_authentication = false

}