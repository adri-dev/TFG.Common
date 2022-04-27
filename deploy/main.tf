terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.95.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfg-k8s-rg"
    storage_account_name = "tfgk8sterraformstate"
    container_name       = "tfstate"
    key                  = "NxO+fwNupwtmG1j8NUXAHwXe/vk10uyCsh/wLGDUDteZNa/n412rTSI7Negi+L0w0Er8n3y7tLaHLWv6V8SZug=="
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = true
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = "North Europe"
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.agent_count
    vm_size    = "standard_d2as_v5"
  }

  service_principal {
    client_id     = var.ARM_CLIENT_ID
    client_secret = var.ARM_CLIENT_SECRET
  }

  tags = {
    Environment = "Development"
  }
}
