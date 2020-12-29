resource "azurerm_sql_server" "sqlserver" {
  name                         = "fsz-udrone-${var.env}-sqlsrv"
  version                      = "12.0"
  resource_group_name          = var.rg_name
  location                     = var.rg_location
  administrator_login          = "fsamiez"
  administrator_login_password = var.sql_srv_password
}

resource "azurerm_sql_database" "sqldatabase" {
  name                = "fsz-udrone-${var.env}-sqldb"
  resource_group_name = var.rg_name
  location            = var.rg_location
  server_name         = azurerm_sql_server.sqlserver.name
  edition             = "Basic"
}

resource "azurerm_sql_firewall_rule" "fwr_sqlsrv" {
    name = "fwr_sqldb"
    resource_group_name = var.rg_name
    server_name = azurerm_sql_server.sqlserver.name
    start_ip_address = "0.0.0.0"
    end_ip_address = "255.255.255.255"
}

resource "null_resource" "db_initialization" {
    depends_on = ["azurerm_sql_firewall_rule.fwr_sqlsrv"]

    provisioner "local-exec" {
        
    }   
}