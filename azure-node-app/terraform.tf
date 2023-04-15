terraform {

  cloud {
    organization = "node-aws-app-org"

    workspaces {
      name = "node-azure-terraform-cloud"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.48.0"
    }
  }
}