# Alkira IPSEC Connector
This module makes it easy to provision an [Alkira IPSEC Connector](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_ipsec).

## Baisc Usage
```hcl
module "connect_ipsec" {
  source  = "alkiranet/connector-ipsec/alkira"
  version = "0.1.0"

  name              = "east-ipsec"
  cxp               = "US-EAST-2"
  segment           = "business"
  group             = "cloud"

  routing_options = {
    type                 = "DYNAMIC"
    customer_gateway_asn = "65310"
  }

  endpoint = [
    {
      name           = "endpoint-a"
      customer_gateway_ip  = "1.1.1.1"
      preshared_keys       = ["01234", "56789"]
      billing_tags         = ["network", "corp"]
    },
    {
      name           = "endpoint-b"
      customer_gateway_ip  = "1.1.1.2"
      preshared_keys       = ["01234", "56789"]
      billing_tags         = ["network", "retail"]
    }
  ]

}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_alkira"></a> [alkira](#requirement\_alkira) | >= 0.9.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alkira"></a> [alkira](#provider\_alkira) | >= 0.9.7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alkira_connector_ipsec.connector](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_ipsec) | resource |
| [alkira_billing_tag.tag](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/billing_tag) | data source |
| [alkira_group.group](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/group) | data source |
| [alkira_segment.segment](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/segment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advertise_on_prem_routes"></a> [advertise\_on\_prem\_routes](#input\_advertise\_on\_prem\_routes) | Advertise on-premises routes | `bool` | `false` | no |
| <a name="input_allow_nat_exit"></a> [allow\_nat\_exit](#input\_allow\_nat\_exit) | Allow access to internet when traffice arrives via connector | `bool` | `true` | no |
| <a name="input_cxp"></a> [cxp](#input\_cxp) | CXP to provision connector in | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Status of connector | `bool` | `true` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | n/a | <pre>list(object({<br>    customer_gateway_ip       = optional(string)<br>    enable_tunnel_redundancy  = optional(bool)<br>    ha_mode                   = optional(string)<br>    preshared_keys            = optional(list(string))<br>    name                      = optional(string)<br>    billing_tags              = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_group"></a> [group](#input\_group) | Group to associate with connector | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of connector | `string` | n/a | yes |
| <a name="input_routing_options"></a> [routing\_options](#input\_routing\_options) | Routing option for VPN mode 'ROUTE\_BASED' | <pre>object({<br>    availability          = optional(string, "IPSEC_INTERFACE_PING")<br>    bgp_auth_key          = optional(string, "")<br>    customer_gateway_asn  = optional(string, "")<br>    type                  = optional(string, "DYNAMIC")<br>  })</pre> | `{}` | no |
| <a name="input_segment"></a> [segment](#input\_segment) | Segment to provision connector in | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Size of connector | `string` | `"SMALL"` | no |
| <a name="input_vpn_mode"></a> [vpn\_mode](#input\_vpn\_mode) | VPN mode for IPSEC connector | `string` | `"ROUTE_BASED"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connector_id"></a> [connector\_id](#output\_connector\_id) | ID of connector |
| <a name="output_implicit_group_id"></a> [implicit\_group\_id](#output\_implicit\_group\_id) | ID of implicit group automatically created with connector |
<!-- END_TF_DOCS -->