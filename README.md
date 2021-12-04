## Description

This module deploys a custom VPC with an internal DNS zone and google services endpoints
## Example

```
module "vpc" {
  source = "git@github.com:VasseurLaurent/google_custom_vpc.git"
  name   = "test"
  subnets = {
    "public" = {
      "name"          = "public",
      "region"        = "asia-east1",
      "ip_cidr_range" = "10.0.1.0/24"
    },
    "private" = {
      "name"          = "private",
      "region"        = "asia-east1",
      "ip_cidr_range" = "10.0.2.0/24"
    },
    "secured" = {
      "name"          = "secured",
      "region"        = "asia-east1",
      "ip_cidr_range" = "10.0.3.0/24"
    },
  }
  internal_dns_name = "test.internal.com."
  google_service_connection = {
    "network" = {
      service       = "servicenetworking.googleapis.com"
      prefix_length = 24
    }
  }
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.allocation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.subnets](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_dns_managed_zone.internal-zone](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_service_networking_connection.endpoint](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_service_connection"></a> [google\_service\_connection](#input\_google\_service\_connection) | Map of google service endpoints attached to the google VPC | <pre>map(object({<br>    service       = string,<br>    prefix_length = number<br>  }))</pre> | `{}` | no |
| <a name="input_internal_dns_name"></a> [internal\_dns\_name](#input\_internal\_dns\_name) | DNS name of the DNS zone | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the VPC and its subresources | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | <pre>map(object({<br>    name          = string<br>    region        = string<br>    ip_cidr_range = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_private_zone_id"></a> [dns\_private\_zone\_id](#output\_dns\_private\_zone\_id) | Private DNS zone id |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Subnets details |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC id |
