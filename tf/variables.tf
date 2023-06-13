variable "use_msi_to_authenticate" {
  description = "Use a managed service identity to authenticate"
  type        = bool
  default     = false
}

variable "azure_environment" {
  description = "Which Azure Environment being used"
  type        = string
  default     = "public"
}

variable "tenant_id" {
  description = "Azure AD Tenant Id the resources are associated with"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription the resources managed in"
  type        = string
}

variable "resource_group_name" {
  description = "Specific resource group to deploy resources into.  If not supplied, will default to servicename-environmentname"
  type        = string
  default     = null
}

variable "service_name" {
  description = "Name of the service"
  type        = string
  default     = "fanplan"
}

variable "environment" {
  description = "What type of environment (dev,test,prod)"
  type        = string
}

variable "region" {
  description = "Azure region to deploy resources to"
  type        = string
}

variable "secret_readers" {
  description = "Users or groups who are able to read secret values"
  type        = list(string)
}