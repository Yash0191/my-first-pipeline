terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.42.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg_tfstate"
    storage_account_name = "stgtfstate11"
    container_name       = "okcontainer"
    key                  = "terraform.tfstate"

  }

}

provider "azurerm" {
  features {}
  subscription_id = "99c7c7ea-a267-488b-9d38-a2547f06712c"
}