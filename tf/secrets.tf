resource "azurerm_key_vault" "app" {
  name                        = "${var.service_name}-${var.environment}"
  location                    = azurerm_resource_group.primary.location
  resource_group_name         = azurerm_resource_group.primary.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = local.default_retention_days
  purge_protection_enabled    = true

  tags = {
    description = "Holds all secrets and keys for the platform"
  }
}

resource "azurerm_key_vault_access_policy" "app_owner" {
  key_vault_id       = azurerm_key_vault.app.id
  tenant_id          = var.tenant_id
  object_id          = local.executing_serviceprincipal_id
  secret_permissions = local.default_secret_permissions
}

resource "azurerm_key_vault_access_policy" "secret_reader" {
  for_each = toset(var.secret_readers)

  key_vault_id       = azurerm_key_vault.app.id
  tenant_id          = var.tenant_id
  object_id          = each.value
  secret_permissions = ["Get", "List"]
}

#------------------ Secret Values -------------------------
resource "random_pet" "machine_admin" {
  length = 20
}
resource "random_password" "machine_admin" {
  length = 20
}

resource "azurerm_key_vault_secret" "machine_admin_password" {
  name         = "machine-admin-name"
  value        = random_pet.machine_admin
  key_vault_id = azurerm_key_vault.app.id
}

resource "azurerm_key_vault_secret" "machine_admin_name" {
  name         = "machine-admin-password"
  value        = random_password.machine_admin.result
  key_vault_id = azurerm_key_vault.app.id
}
