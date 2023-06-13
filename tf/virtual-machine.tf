resource "azurerm_windows_virtual_machine" "primary" {
  name                  = "${var.service_name}-${var.environment}"
  admin_username        = azurerm_key_vault_secret.machine_admin_name
  admin_password        = azurerm_key_vault_secret.machine_admin_password
  location              = azurerm_resource_group.primary.location
  resource_group_name   = azurerm_resource_group.primary.name
  network_interface_ids = [azurerm_network_interface.primary.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }


  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.app.primary_blob_endpoint
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "primary" {
  virtual_machine_id = azurerm_windows_virtual_machine.primary.id
  location           = azurerm_resource_group.primary.location
  enabled            = true

  daily_recurrence_time = "1700"
  timezone              = "Pacific Standard Time"

  notification_settings {
    enabled         = false
  }
}