# Configure the Azure provider

locals {
  env = terraform.workspace
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.26"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "fsz-udrone-${local.env}"
  location = "francecentral"
}

resource "azurerm_storage_account" "sa" {
  name                     = "fszudrone${local.env}sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

module "keyvault" {
  source   = "./keyvault"
  location = azurerm_resource_group.rg.location
  rg_name  = azurerm_resource_group.rg.name
  env      = local.env
}

module "database" {
  source           = "./database"
  env              = local.env
  rg_name          = azurerm_resource_group.rg.name
  rg_location      = azurerm_resource_group.rg.location
  sql_srv_password = module.keyvault.fsamiez_sqlsrv_password
}