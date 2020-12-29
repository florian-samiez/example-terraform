resource "random_password" "sql_server_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_key_vault" "key_vault" {
  name                        = "fsa-udrone-${var.env}-kv"
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current_config.tenant_id
  soft_delete_enabled         = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  access_policy {
    tenant_id       = data.azurerm_client_config.current_config.tenant_id
    object_id       = data.azurerm_client_config.current_config.object_id
    key_permissions = ["get", ]
    secret_permissions = [
      "set",
      "get",
      "delete",
      "purge",
      "recover",
      "list",
    ]
    storage_permissions = ["get", ]
  }
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = [chomp(data.http.myip.body), ]
  }
}

resource "azurerm_key_vault_secret" "sqlsrv_secret" {
  name         = "fsamiez-sqlsrv-password"
  value        = random_password.sql_server_password.result
  key_vault_id = azurerm_key_vault.key_vault.id
}
