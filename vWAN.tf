# vWAN Resources
# vWAN
resource "azurerm_virtual_wan" "vwan1" {
  provider            = azurerm.hub-sub
  name                = "vWAN-${var.app-name}-01"
  resource_group_name = azurerm_resource_group.vwan-rg1.name
  location            = var.region1

  # Configuration 
  office365_local_breakout_category = "OptimizeAndAllow"

  tags = {
    Environment = var.environment_tag
  }
}
# vWAN Hub 1
resource "azurerm_virtual_hub" "region1-vhub1" {
  provider            = azurerm.hub-sub
  name                = "vWAN-hub-${var.region1}-01"
  resource_group_name = azurerm_resource_group.vwan-rg1.name
  location            = var.region1
  virtual_wan_id      = azurerm_virtual_wan.vwan1.id
  address_prefix      = var.vwan-region1-hub1-prefix1

  tags = {
    Environment = var.environment_tag
  }
}

# vWAN Hub Connection 1
resource "azurerm_virtual_hub_connection" "region1-connection1" {
  provider                  = azurerm.hub-sub
  name                      = "${var.region1}-conn-vnet1-to-vwan-hub"
  virtual_hub_id            = azurerm_virtual_hub.region1-vhub1.id
  remote_virtual_network_id = azurerm_virtual_network.region1-vnet1.id
}
