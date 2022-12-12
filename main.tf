data "alkira_billing_tag" "tag" {
  for_each = {
    for k, v in toset(local.filter_billing_tags) : k => v
  }
  name     = each.key
}

data "alkira_group" "group" {
  name = var.group
}

data "alkira_segment" "segment" {
  name = var.segment
}

locals {

  filter_billing_tags = flatten([
    for e in var.endpoint : [
      for tag in e.billing_tags : 
        tag
    ]
  ])

  filter_endpoint_options = flatten([
    for e in var.endpoint : {
      billing_tag_ids      = [for tag in e.billing_tags : lookup(data.alkira_billing_tag.tag, tag, null).id]
      customer_gateway_ip  = e.customer_gateway_ip
      preshared_keys       = e.preshared_keys
      name                 = e.name
    }
  ])

}

/*
alkira_connector_ipsec
https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/connector_ipsec
*/
resource "alkira_connector_ipsec" "connector" {

  # Connector values
  cxp                             = var.cxp
  enabled                         = var.enabled
  group                           = data.alkira_group.group.name
  name                            = var.name
  segment_id                      = data.alkira_segment.segment.id
  size                            = var.size
  vpn_mode                        = var.vpn_mode

  # nested schema for endpoints
  dynamic "endpoint" {
    for_each = {
      for o in local.filter_endpoint_options : o.name => o
    }

    content {
      customer_gateway_ip  = endpoint.value.customer_gateway_ip
      preshared_keys       = endpoint.value.preshared_keys
      name                 = endpoint.value.name
      billing_tag_ids      = endpoint.value.billing_tag_ids
    }
  }

  # if vpn mode is route-based
  routing_options {
    availability          = var.routing_options.availability
    bgp_auth_key          = var.routing_options.bgp_auth_key
    customer_gateway_asn  = var.routing_options.customer_gateway_asn 
    type                  = var.routing_options.type
  }

  # if segment options enabled
  segment_options {
    advertise_on_prem_routes  = var.advertise_on_prem_routes
    allow_nat_exit            = var.allow_nat_exit
    name                      = data.alkira_segment.segment.name
  }

}