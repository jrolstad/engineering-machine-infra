locals {
  resource_group_name           = coalesce(var.resource_group_name, "${var.service_name}-${var.environment}")
  executing_serviceprincipal_id = data.azuread_client_config.current.object_id

  default_secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]
  default_retention_days = 7
}
