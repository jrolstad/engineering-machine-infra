resource "azurerm_resource_group" "primary" {
  name     = var.resource_group_name
  location = var.region

  tags = {
    environment = var.environment
    service     = var.service_name
  }
}

resource "azurerm_management_lock" "resource_group_lock" {
  name       = azurerm_resource_group.primary.name
  scope      = azurerm_resource_group.primary.id
  lock_level = "CanNotDelete"
  notes      = "Only IaC should modify"
}