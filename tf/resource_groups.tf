resource "azurerm_resource_group" "primary" {
  name     = local.resource_group_name
  location = var.region

  tags = {
    environment = var.environment
    service     = var.service_name
  }
}