data "azurerm_client_config" "current_config" {}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}