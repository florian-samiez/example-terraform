# Configure the Azure provider

locals {
  env = terraform.workspace
}

terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">=2.26"
        }
    }
}

resource "random_password" "sql_server_password" {
    length = 16
    special = true
    override_special = "_%@"
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
    name = "fsz-udrone-${local.env}"
    location = "francecentral"
}

resource "azurerm_storage_account" "sa" {
    name = "fszudrone${local.env}sa"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_sql_server" "sqlserver" {
    name = "fsz-udrone-${local.env}-sqlsrv"
    version = "12.0"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    administrator_login = "fsamiez"
    administrator_login_password = random_password.sql_server_password.result
}

resource "azurerm_sql_database" "sqldatabase" {
    name = "fsz-udrone-${local.env}-sqldb"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    server_name = azurerm_sql_server.sqlserver.name
    edition = "Basic"
}