terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }

  }
  required_version = ">= 1.1.0"
  
  cloud {
    organization = "shriramrajaraman"

    workspaces {
      name = "gcp-githubActions-demo"
    }
  }
}

provider "google" {
  project      = "hc-ba2320067c904daea31de2e996c"
  region       = "australia-southeast1"
  zone         = "australia-southeast1-a"
}

resource "google_compute_network" "vpc_network" {
  name = "sam-demo-vpc-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "sam-terraform-instance-demo"
  machine_type = "e2-medium"
  tags = ["gh-action", "demo"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

