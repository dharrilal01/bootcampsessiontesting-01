# Resource Group - vWAN
resource "azurerm_resource_group" "vwan-rg1" {
  provider = azurerm.hub-sub
  name     = "rg-${var.app-name}-vwan-001"
  location = var.region1
  tags = {
    Environment = var.environment_tag
    Function    = "vWAN-DemoLab-ResourceGroups"
  }
}
# Resource Group - vNET
resource "azurerm_resource_group" "vnet-rg1" {
  provider = azurerm.spoke-sub
  name     = "rg-${var.app-name}-vnet-001"
  location = var.region1
  tags = {
    Environment = var.environment_tag
    Function    = "vNET-DemoLab-ResourceGroups"
  }
}
# Resource Group - VM
resource "azurerm_resource_group" "vm-rg1" {
  provider = azurerm.spoke-sub
  name     = "rg-${var.vmfunc}-app-001"
  location = var.region1
  tags = {
    Environment = var.environment_tag
    Function    = "VM-DemoLab-ResourceGroups"
  }
}