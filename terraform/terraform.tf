terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 2.41"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.0"
    }
  }

  required_version = ">= 1.7"
}