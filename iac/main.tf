terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.95.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfg-k8s"
    storage_account_name = "tfgterraformst"
    container_name       = "tfstate"
    key                  = "4tkA9pYy4g4ik3nPmQ6e+vbtvB9D/B1ie1wY9RnsLxnd2SGooGQ2s92eEQlwb9S21I0CesmicFqug6MNHl2sBQ=="
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
  location            = data.azurerm_resource_group.rg.location
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

resource "azurerm_mssql_server" "sql" {
  name                         = "tfg-sql-svr"
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = "centralindia"
  version                      = "12.0"
  administrator_login          = var.SQL_USER
  administrator_login_password = var.SQL_PASSWORD

  tags = {
    environment = "Development"
  }
}
