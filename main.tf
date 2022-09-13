terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }

    doormat = {
      source  = "doormat.hashicorp.services/hashicorp-security/doormat"
      version = "~> 0.0.2"
    }

  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "samuelleezy-hashicorp-demo"

    workspaces {
      name = "gcp-githubActions-demo"
    }
  }
}

provider "doormat" {
  data "doormat_gcp_credentials" "creds" {
    provider = doormat

    service_account = "samuel.lee@hashicorp.com"
    project_id      = "hc-ba2320067c904daea31de2e996c"
  }
}

provider "google" {
  access_token = data.doormat_gcp_credentials.creds.access_token
  project      = "hc-ba2320067c904daea31de2e996c"
  region       = "us-central1"
  zone         = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "sam-gpc-vpcNetwork"
}

