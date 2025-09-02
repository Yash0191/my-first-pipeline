locals {
  common_tags = {
    "ManageBy"    = "Terraform"
    "Owner"       = "TodoAppTeam"
    "Environment" = "dev"
  }
}


module "rg" {
  source      = "../../Modules/azurerm_resource_group"
  rg_name     = "rg-dev-todoapp"
  rg_location = "centralindia"
  rg_tags     = local.common_tags
}

module "stg" {
  source       = "../../Modules/azurerm_storage_account"
  depends_on = [ module.rg ]
  stg_name     = "stgdevtodoapp"
  stg_location = "centralindia"
  rg_name      = "rg-dev-todo"
  tags         = local.common_tags
}

module "acr" {
  source   = "../../Modules/azurerm_container_registry"
  acr-name = "acrdevtodoapp"
  rg_name  = "rg-dev-todo"
  location = "centralindia"
  depends_on = [ module.rg ]
  tags     = local.common_tags

}

module "KeyVault" {
  source   = "../../Modules/azurerm_key_vault"
  key_name = "key-dev-todoapp"
  rg_name  = "rg-dev-todo"
  location = "centralindia"
  depends_on = [ module.rg ]
  tags     = local.common_tags

}

module "sql_server" {
  source         = "../../Modules/azurerm_sql_server"
  sqlserver      = "server-dev-todoapp"
  rg_name        = "rg-dev-todo"
  rg_location    = "centralindia"
  admin_user     = "yashadmin"
  admin_password = "yashadmin@123"
  tags           = local.common_tags
}

module "sql_db" {
  source      = "../../Modules/azurerm_sql_database"
  depends_on = [ module.sql_server ]
  sql_db      = "sqldb-dev-todoapp"
  server_id   = module.sql_server.server_id
  max_size_gb = "2"
  tags        = local.common_tags
}

module "aks" {
  source     = "../../Modules/azurerm_kubernet_cluster"
  depends_on = [ module.rg ]
  aks_name   = "aks-dev-todoapp"
  dns_prefix = "aks-dev-todoapp"
  rg_name    = "rg-dev-todo"
  location   = "centralindia"
  tags       = local.common_tags
}