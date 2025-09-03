resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sqlserver
  resource_group_name          = var.rg_name
  location                     = var.rg_location
  version                      = "12.0"
  administrator_login          = var.admin_user
  administrator_login_password = var.admin_password
  minimum_tls_version          = "1.2"

  tags = var.tags
}
