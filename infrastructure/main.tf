provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "aks-h09-rg"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "app" {
  name                = "aks-h09-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "h09dns"

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_B2s"
    node_count = 1
    min_count  = 1
    max_count  = 3
    enable_auto_scaling = true
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = null # use latest available version

  tags = {
    environment = "dev"
  }
}