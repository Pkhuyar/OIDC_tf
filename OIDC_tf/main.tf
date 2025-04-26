resource "random_id" "unique" {
  byte_length = 4
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-github-oidc-${random_id.unique.hex}"
  location = "East US"
}

resource "azurerm_service_plan" "plan" {
  name                = "serviceplan-${random_id.unique.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "B1"
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "github-oidc-app-${random_id.unique.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
