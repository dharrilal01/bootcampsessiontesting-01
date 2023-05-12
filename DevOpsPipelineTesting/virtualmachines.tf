# Virtual Machines
#Public IPs
resource "azurerm_public_ip" "region1-vm01-pip" {
  provider            = azurerm.spoke-sub
  name                = "pip-vm01-${var.region1}-001"
  resource_group_name = azurerm_resource_group.vm-rg1.name
  location            = var.region1
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.environment_tag
  }
}

#Create NICs and associate the Public IPs
resource "azurerm_network_interface" "region1-vm01-nic" {
  provider            = azurerm.spoke-sub
  name                = "nic-vm01-${var.region1}-001"
  location            = var.region1
  resource_group_name = azurerm_resource_group.vm-rg1.name


  ip_configuration {
    name                          = "ipconf-vm01-${var.region1}-001"
    subnet_id                     = azurerm_subnet.region1-vnet1-snet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.region1-vm01-pip.id
  }

  tags = {
    Environment = var.environment_tag
  }
}
#Create VMs
resource "azurerm_windows_virtual_machine" "region1-vm01" {
  provider            = azurerm.spoke-sub
  name                = "vm01${var.vmfunc}"
  resource_group_name = azurerm_resource_group.vm-rg1.name
  location            = var.region1
  size                = var.vmsize
  admin_username      = var.adminusername
  admin_password      = var.adminpassword
  network_interface_ids = [
    azurerm_network_interface.region1-vm01-nic.id,
  ]

  tags = {
    Environment = var.environment_tag
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Setup Scripts for Apps and Windows Firewall
resource "azurerm_virtual_machine_extension" "region1-vm01-vmsetup" {
  provider             = azurerm.spoke-sub
  name                 = "vm01-vmsetup-001"
  virtual_machine_id   = azurerm_windows_virtual_machine.region1-vm01.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell.exe -Command \"./standard_VMSetup.ps1; exit 0;\""
    }
  PROTECTED_SETTINGS

  settings = <<SETTINGS
    {
        "fileUris": [
          "https://raw.githubusercontent.com/dharrilal/AzurevWAN/main/Scripts/Powershell/standard_VMSetup.ps1"
        ]
    }
  SETTINGS
}