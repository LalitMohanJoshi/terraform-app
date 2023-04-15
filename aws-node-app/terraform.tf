terraform {

  cloud {
    organization = "node-aws-app-org"

    workspaces {
      name = "node-aws-terraform-cloud"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}
