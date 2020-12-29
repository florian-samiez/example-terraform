output "fsamiez_sqlsrv_password" {
  value       = azurerm_key_vault_secret.sqlsrv_secret.value
  description = "Generated password for SQL server"
  sensitive   = true
}