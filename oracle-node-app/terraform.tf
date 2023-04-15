terraform {

  cloud {
    organization = "node-aws-app-org"

    workspaces {
      name = "node-oracle-terraform-cloud"
    }
  }

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.113.0"
    }
  }
}