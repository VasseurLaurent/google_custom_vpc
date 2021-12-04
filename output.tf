output "vpc_id" {
  value       = google_compute_network.vpc.id
  description = "VPC id"
}

output "subnets" {
  value       = google_compute_subnetwork.subnets[*]
  description = "Subnets details"
}

output "dns_private_zone_id" {
  value       = google_dns_managed_zone.internal-zone.id
  description = "Private DNS zone id"
}
