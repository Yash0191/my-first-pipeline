resource "azurerm_storage_account" "stg" {
  name                     = var.stg_name
  resource_group_name      = var.rg_name
  location                 = var.stg_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = var.tags

}


