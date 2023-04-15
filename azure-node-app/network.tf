# az account list-locations

# Create a resource group

resource "azurerm_resource_group" "node-app-group" {
  name     = "node-app-resource-group"
  location = "Central India"
}

# create virtual network for resource group

resource "azurerm_virtual_network" "node-app-vn" {
  name                = "node-app-virtual-network"
  resource_group_name = azurerm_resource_group.node-app-group.name
  location            = azurerm_resource_group.node-app-group.location
  address_space       = ["10.0.0.0/16"]
}

# create subnet for virtual network

resource "azurerm_subnet" "node-app-vns" {
  name                 = "node-app-virtual-network-subnet"
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.node-app-vn.name
  resource_group_name  = azurerm_resource_group.node-app-group.name
}

# create network security group

resource "azurerm_network_security_group" "node-app-nsg" {
  depends_on = [
    azurerm_resource_group.node-app-group
  ]

  name                = "node-app-network-security-group"
  location            = azurerm_resource_group.node-app-group.location
  resource_group_name = azurerm_resource_group.node-app-group.name

  security_rule {
    name                       = "AllowHttp"
    description                = "Allow Http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSsh"
    description                = "Allow Ssh"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

# attach network security group with subnet

resource "azurerm_subnet_network_security_group_association" "node-app-nsg-association" {
  depends_on = [
    azurerm_resource_group.node-app-group
  ]
  subnet_id                 = azurerm_subnet.node-app-vns.id
  network_security_group_id = azurerm_network_security_group.node-app-nsg.id
}

# get public ip for a vm

resource "azurerm_public_ip" "node-app-vm-ip" {
  depends_on = [
    azurerm_resource_group.node-app-group
  ]

  name                = "node-app-vm-public-ip"
  location            = azurerm_resource_group.node-app-group.location
  resource_group_name = azurerm_resource_group.node-app-group.name
  allocation_method   = "Static"
}

# create network card for vm

resource "azurerm_network_interface" "node-app-nic" {
  depends_on = [
    azurerm_resource_group.node-app-group
  ]

  name                = "node-app-nic"
  location            = azurerm_resource_group.node-app-group.location
  resource_group_name = azurerm_resource_group.node-app-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.node-app-vns.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.node-app-vm-ip.id
  }
}