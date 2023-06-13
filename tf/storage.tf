resource "azurerm_storage_account" "app" {
  name                     = replace("${var.service_name}app${var.environment}", "-", "")
  resource_group_name      = azurerm_resource_group.primary.name
  location                 = azurerm_resource_group.primary.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    description = "Captures all infrastructure specific blob storage needs"
  }
}