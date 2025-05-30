terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.3"
}

provider "azurerm" {
  features {}

  use_oidc        = true
  client_id       = var.client_id
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

