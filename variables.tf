variable "advertise_on_prem_routes" {
  description  = "Advertise on-premises routes"
  type         = bool
  default      = false
}

variable "allow_nat_exit" {
  description  = "Allow access to internet when traffice arrives via connector"
  type         = bool
  default      = true
}

variable "cxp" {
  description  = "CXP to provision connector in"
  type         = string
}

variable "enabled" {
  description  = "Status of connector"
  type         = bool
  default      = true
}

variable "endpoint" {
  description = ""

  type = list(object({
    customer_gateway_ip       = optional(string)
    enable_tunnel_redundancy  = optional(bool)
    ha_mode                   = optional(string)
    preshared_keys            = optional(list(string))
    name                      = optional(string)
    billing_tags              = optional(list(string))
  }))
  default = []
}

variable "group" {
  description  = "Group to associate with connector"
  type         = string
  default      = ""
}

variable "name" {
  description  = "Name of connector"
  type         = string
}

variable "routing_options" {
  description  = "Routing option for VPN mode 'ROUTE_BASED'"

  type = object({
    availability          = optional(string, "IPSEC_INTERFACE_PING")
    bgp_auth_key          = optional(string, "")
    customer_gateway_asn  = optional(string, "")
    type                  = optional(string, "DYNAMIC")
  })
  default = {}
}

variable "segment" {
  description  = "Segment to provision connector in"
  type         = string
}

variable "size" {
  description  = "Size of connector"
  type         = string
  default      = "SMALL"
}

variable "vpn_mode" {
  description  = "VPN mode for IPSEC connector"
  type         = string
  default      = "ROUTE_BASED"
}