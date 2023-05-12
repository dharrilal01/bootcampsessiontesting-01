# Networks 
# Region 1 VNET 1
resource "azurerm_virtual_network" "region1-vnet1" {
  provider            = azurerm.spoke-sub
  name                = "vnet-${var.environment_tag}-001"
  location            = var.region1
  resource_group_name = azurerm_resource_group.vnet-rg1.name
  address_space       = [var.region1-vnet1-address-space]
  tags = {
    Environment = var.environment_tag
  }
}
resource "azurerm_subnet" "region1-vnet1-snet1" {
  provider             = azurerm.spoke-sub
  name                 = "snet-vnet-001-${var.environment_tag}-001"
  resource_group_name  = azurerm_resource_group.vnet-rg1.name
  virtual_network_name = azurerm_virtual_network.region1-vnet1.name
  address_prefixes     = [var.region1-vnet1-snet1-range]
}

# NSGs
resource "azurerm_network_security_group" "region1-nsg" {
  provider            = azurerm.spoke-sub
  name                = "nsg-${var.environment_tag}-001"
  location            = var.region1
  resource_group_name = azurerm_resource_group.vnet-rg1.name

  security_rule {
    name                       = "RDP-In"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    Environment = var.environment_tag
  }
}

# NSG Association
resource "azurerm_subnet_network_security_group_association" "region1-vnet1-snet1" {
  provider                  = azurerm.spoke-sub
  subnet_id                 = azurerm_subnet.region1-vnet1-snet1.id
  network_security_group_id = azurerm_network_security_group.region1-nsg.id
}
