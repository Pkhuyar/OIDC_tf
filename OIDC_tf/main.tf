resource "azurerm_resource_group" "rg" {
  name     = "github-oidc-rg"
  location = "East US"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "github-oidc-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "github-oidc-app-${random_id.unique.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version = "PYTHON|3.11"
  }
}
