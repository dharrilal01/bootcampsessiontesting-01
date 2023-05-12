#Providers
terraform {
  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 3.41.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.3"
    }
  }
}
#Features
provider "azurerm" {
  features {}
}
provider "azurerm" {
  alias           = "hub-sub"
  subscription_id = var.subscription_id_hub
  features {}
}
provider "azurerm" {
  alias           = "spoke-sub"
  subscription_id = var.subscription_id_spoke
  features {}
}