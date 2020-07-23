locals {
  bastion-name    = "AzureBastionSubnet"
}

resource "azurerm_resource_group" "vnet-rg" {
  name     = var.vnet-resource-group
  location = var.vnet-location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name
  address_space       = [var.vnet-address-space]
  dns_servers         = var.vnet-dns-servers

  tags = {
    Environment = "Testing"
  }
}

#Create Default Subnet
resource "azurerm_subnet" "vnet-default" {
  name                 = var.default-name
  resource_group_name  = azurerm_resource_group.vnet-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.default-subnet
}

#Create Subnet for Bastion Host
resource "azurerm_subnet" "vnet-bastion-subnet" {
  name                 = local.bastion-name
  resource_group_name  = azurerm_resource_group.vnet-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.bastion-subnet
}

#Create Public IP for Bastion Host
resource "azurerm_public_ip" "bastion-public-ip" {
  name                = "${var.bastion-host-name}-pip"
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Create Bastion Host
resource "azurerm_bastion_host" "bastion-host" {
  name                = var.bastion-host-name
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.vnet-bastion-subnet.id
    public_ip_address_id = azurerm_public_ip.bastion-public-ip.id
  }
}

#Create NSG for Bastion Subnet
resource "azurerm_network_security_group" "bastion-nsg" {
  name                = "${var.bastion-host-name}-nsg"
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name

  security_rule {
    name                       = "bastion-in-allow"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "bastion-control-in-allow"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443", "4443"]
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "bastion-in-deny"
    priority                   = 900
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "bastion-vnet-out-allow"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_ranges         = ["22", "3389"]
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "bastion-azure-out-allow"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "443"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
  }
}

#Accosiate NSG with Bastion Subnet
resource "azurerm_subnet_network_security_group_association" "bastion-nsg" {
  subnet_id                 = azurerm_subnet.vnet-bastion-subnet.id
  network_security_group_id = azurerm_network_security_group.bastion-nsg.id
}