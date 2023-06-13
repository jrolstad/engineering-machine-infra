resource "azurerm_windows_virtual_machine" "primary" {
  name                  = "${var.service_name}-${var.environment}"
  admin_username        = azurerm_key_vault_secret.machine_admin_name.value
  admin_password        = azurerm_key_vault_secret.machine_admin_password.value
  location              = azurerm_resource_group.primary.location
  resource_group_name   = azurerm_resource_group.primary.name
  network_interface_ids = [azurerm_network_interface.primary.id]
  size                  = "Standard_D8s_v4"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-11"
    sku       = "win11-21h2-pro"
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
    enabled = false
  }
}