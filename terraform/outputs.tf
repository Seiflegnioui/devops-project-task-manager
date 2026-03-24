data "azurerm_public_ip" "master" {
  name                = azurerm_public_ip.master_ip.name
  resource_group_name = azurerm_linux_virtual_machine.master.resource_group_name
}

data "azurerm_public_ip" "worker" {
  name                = azurerm_public_ip.worker_ip.name
  resource_group_name = azurerm_linux_virtual_machine.worker.resource_group_name
}

output "master_public_ip" {
  value = data.azurerm_public_ip.master.ip_address
}

output "worker_public_ip" {
  value = data.azurerm_public_ip.worker.ip_address
}

# Generate Ansible Inventory locally
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.ini.tpl", {
    master_ip = data.azurerm_public_ip.master.ip_address
    worker_ip = data.azurerm_public_ip.worker.ip_address
    user      = var.admin_username
  })
  filename = "${path.module}/../ansible/inventory.ini"
}
