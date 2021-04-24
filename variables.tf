variable "rg_name" {
  type = string
}

variable "loc_name" {
  type = string
}

variable "hub_vnet_name" {
  type = string
}

variable "hub_vnet_add_space" {
}

variable "gateway_sub_addpre" {
  type = list
}

variable "op_vnet_name" {
  type = string
}

variable "op_vnet_add_space" {
}


variable "spoke1_vnet_name" {
  type = string
}

variable "spoke1_vnet_add_space" {
}

variable "spoke2_vnet_name" {
  type = string
}

variable "spoke2_vnet_add_space" {
}

variable "spoke3_vnet_name" {
  type = string
}

variable "spoke3_vnet_add_space" {
  type = list
}


variable "hub_sub_name" {
  type  = string
}

variable "hub_sub_addpre" {
  type = list
}

variable "op_sub_name" {
  type  = string
}

variable "op_sub_addpre" {
  type = list
}

variable "spoke1_sub_name" {
  type  = string
}

variable "spoke1_sub_addpre" {
  type = list
}

variable "spoke2_sub_name" {
  type  = string
}

variable "spoke3_subnets" {
  type  = string
}

variable "spoke2_sub_addpre" {
  type = list
}

variable "vng_publicip_alloc_method" {
  type = string
}
variable "vng_publicip_name" {
  type = string
}

variable "mv_vng_name" {
  type = string
}
variable "mv_vng_loc" {
  type = string
}
variable "mv_vng_rg" {
  type = string
}
variable "mv_vng_sku" {
  type = string
}
variable "mv_vng_type" {
  type = string
}
variable "mv_vng_vpn_type" {
  type = string
}
/*
    mv_vng_name     = "hub-gateway"
    mv_vng_loc      = module.rg.resource_group_loc
    mv_vng_rg       = module.rg.resource_group_name
    mv_vng_sku      = "Basic"
    mv_vng_type     = "Vpn"
    mv_vng_vpn_type = "RouteBased"
    mv_publicip_gateway_config  = "vnetGatewayConfig"
    mv_publicip_address_id      = module.publicip.publicip_id
    mv_publicip_add_alloc       = "Dynamic"
    mv_publicip_subnet          = module.gateway_subnet.subnet_id
*/