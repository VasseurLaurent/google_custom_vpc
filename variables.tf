variable "name" {
  type        = string
  description = "Name of the VPC and its subresources"
}

variable "subnets" {
  type = map(object({
    name          = string
    region        = string
    ip_cidr_range = string
  }))
}

variable "internal_dns_name" {
  type        = string
  description = "DNS name of the DNS zone"
}

variable "google_service_connection" {
  type = map(object({
    service       = string,
    prefix_length = number
  }))

  description = "Map of google service endpoints attached to the google VPC"
  default     = {}
}
