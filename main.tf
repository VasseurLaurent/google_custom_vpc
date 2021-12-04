/*
* ## Description
*
* This module deploys a custom VPC with an internal DNS zone and google services endpoints
* ## Example
*
* ```
* module "vpc" {
*   source = "git@github.com:VasseurLaurent/google_custom_vpc.git"
*   name   = "test"
*   subnets = {
*     "public" = {
*       "name"          = "public",
*       "region"        = "asia-east1",
*       "ip_cidr_range" = "10.0.1.0/24"
*     },
*     "private" = {
*       "name"          = "private",
*       "region"        = "asia-east1",
*       "ip_cidr_range" = "10.0.2.0/24"
*     },
*     "secured" = {
*       "name"          = "secured",
*       "region"        = "asia-east1",
*       "ip_cidr_range" = "10.0.3.0/24"
*     },
*   }
*   internal_dns_name = "test.internal.com."
*   google_service_connection = {
*     "network" = {
*       service       = "servicenetworking.googleapis.com"
*       prefix_length = 24
*     }
*   }
* }
* ```
*/

resource "google_compute_network" "vpc" {
  name                    = var.name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnets" {
  for_each      = var.subnets
  name          = "${var.name}-${each.value.name}"
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  network       = google_compute_network.vpc.id
}


resource "google_dns_managed_zone" "internal-zone" {
  name        = "${var.name}-internal-zone"
  dns_name    = var.internal_dns_name
  description = "Internal zone of VPC: ${var.name}"
  visibility  = "private"
  private_visibility_config {
    networks {
      network_url = google_compute_network.vpc.id
    }
  }
}

resource "google_compute_global_address" "allocation" {
  for_each      = var.google_service_connection
  name          = "${var.name}-${each.key}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = each.value.prefix_length
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "endpoint" {
  for_each                = var.google_service_connection
  network                 = google_compute_network.vpc.id
  service                 = each.value.service
  reserved_peering_ranges = [google_compute_global_address.allocation[each.key].name]
}
