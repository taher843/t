

module "rg" {
  source    = "./modules/rg"
  rgname    = var.rg_name
  loc       = var.loc_name
}   

module "hub_vnet" {
  source = "./modules/vnet"
    mv_vnet_name        = var.hub_vnet_name
    mv_loc              = module.rg.resource_group_loc
    mv_add_space        = var.hub_vnet_add_space
    mv_rgname           = module.rg.resource_group_name
}

module "hub_subnet" {
  source = "./modules/subnet"
    mv_sub_name         = join("-subnet-",[module.hub_vnet.virtual_network_name],[1])
    mv_sub_loc          = module.rg.resource_group_loc
    mv_sub_rg           = module.rg.resource_group_name
    mv_sub_addpre       = var.hub_sub_addpre
    mv_sub_vnet         = module.hub_vnet.virtual_network_name
}


module "gateway_subnet" {
  source = "./modules/subnet"
    mv_sub_name         = var.gateway_sub_name
    mv_sub_loc          = module.rg.resource_group_loc
    mv_sub_rg           = module.rg.resource_group_name
    mv_sub_addpre       = var.gateway_sub_addpre
    mv_sub_vnet         = module.hub_vnet.virtual_network_name
}

module "op_vnet" {
  source = "./modules/vnet"
    mv_vnet_name        = var.op_vnet_name
    mv_loc              = module.rg.resource_group_loc
    mv_add_space        = var.op_vnet_add_space
    mv_rgname           = module.rg.resource_group_name
}
module "op_subnet" {
  source = "./modules/subnet"
    mv_sub_name         = join("-subnet-",[module.op_vnet.virtual_network_name],[1])
    mv_sub_loc          = module.rg.resource_group_loc
    mv_sub_rg           = module.rg.resource_group_name
    mv_sub_addpre       = var.op_sub_addpre
    mv_sub_vnet         = module.op_vnet.virtual_network_name
}


module "spoke1_vnet" {
  source = "./modules/vnet"
    mv_vnet_name        = var.spoke1_vnet_name
    mv_loc              = module.rg.resource_group_loc
    mv_add_space        = var.spoke1_vnet_add_space
    mv_rgname           = module.rg.resource_group_name
}

module "spoke1_subnet" {
  source = "./modules/subnet"
    mv_sub_name         = join("-subnet-",[module.spoke1_vnet.virtual_network_name],[1])
    mv_sub_loc          = module.rg.resource_group_loc
    mv_sub_rg           = module.rg.resource_group_name
    mv_sub_addpre       = var.spoke1_sub_addpre
    mv_sub_vnet         = module.spoke1_vnet.virtual_network_name
}

module "spoke2_vnet" {
  source = "./modules/vnet"
    mv_vnet_name        = var.spoke2_vnet_name
    mv_loc              = module.rg.resource_group_loc
    mv_add_space        = var.spoke2_vnet_add_space
    mv_rgname           = module.rg.resource_group_name
}

module "spoke2_subnet" {
  source = "./modules/subnet"
    mv_sub_name         = join("-subnet-",[module.spoke2_vnet.virtual_network_name],[1])
    mv_sub_loc          = module.rg.resource_group_loc
    mv_sub_rg           = module.rg.resource_group_name
    mv_sub_addpre       = var.spoke2_sub_addpre
    mv_sub_vnet         = module.spoke2_vnet.virtual_network_name
}

module "spoke3_vnet" {
  source = "./modules/vnet"
    mv_vnet_name        = var.spoke3_vnet_name
    mv_loc              = module.rg.resource_group_loc
    mv_add_space        = var.spoke3_vnet_add_space
    mv_rgname           = module.rg.resource_group_name
}


locals {
        subnets = cidrsubnets(var.spoke3_subnets, 2, 2, 2)
    }
module "spoke3_subnets" {
    source = "./modules/subnet"
    mv_sub_name         = join("-subnet-",[module.spoke3_vnet.virtual_network_name],[count.index+1])
    mv_sub_loc          = module.rg.resource_group_loc
    mv_sub_rg           = module.rg.resource_group_name
    mv_sub_vnet         = module.spoke3_vnet.virtual_network_name
    mv_sub_addpre       = [local.subnets[count.index]]
    count               = length(local.subnets)
}

module "hub-spoke3peering" {
    source = "./modules/vnetpeering"
    mv_source_peer_name     = "${module.hub_vnet.virtual_network_name}-${module.spoke3_vnet.virtual_network_name}"
    mv_source_rg_name       = module.rg.resource_group_name
    mv_source_vnet_name     = module.hub_vnet.virtual_network_name
    mv_source_vnet_id       = module.hub_vnet.virtual_network_id
    mv_destination_peer_name= "${module.spoke3_vnet.virtual_network_name}-${module.hub_vnet.virtual_network_name}"
    mv_destination_rg_name  = module.rg.resource_group_name
    mv_destination_vnet_name= module.spoke3_vnet.virtual_network_name
    mv_destination_vnet_id  = module.spoke3_vnet.virtual_network_id
    mv_allow_vnet_access    = true
    mv_allow_forwarded_traffic = true
    mv_allow_gateway_transit   = true
}


module "hub_publicip" {
  source = "./modules/publicip"
    mv_publicip_name            = var.hub_vng_publicip_name
    mv_publicip_loc             = module.rg.resource_group_loc
    mv_publicip_rg              = module.rg.resource_group_name
    mv_publicip_alloc_method    = var.hub_vng_publicip_alloc_method
}

module "op_publicip" {
  source = "./modules/publicip"
    mv_publicip_name            = var.op_vng_publicip_name
    mv_publicip_loc             = module.rg.resource_group_loc
    mv_publicip_rg              = module.rg.resource_group_name
    mv_publicip_alloc_method    = var.op_vng_publicip_alloc_method
}

module "hub-vnetgateway" {
  source = "./modules/vnetgateway"
    mv_vng_name     = var.hub_vng_vpn_gateway_name
    mv_vng_loc      = module.rg.resource_group_loc
    mv_vng_rg       = module.rg.resource_group_name
    mv_vng_sku      = var.hub_vng_sku
    mv_vng_type     = var.hub_vng_type
    mv_vng_vpn_type = var.hub_vpn_type
    mv_vng_active_active = var.hub_vng_active_active
    mv_vng_bgp           = var.hub_vng_bgp
    mv_vng_publicip_address_id      = module.hub_publicip.publicip_id
    mv_vng_gateway_subnetid          = module.gateway_subnet.subnet_id
}

module "op-vnetgateway" {
  source = "./modules/vnetgateway"
    mv_vng_name     = var.op_vng_vpn_gateway_name
    mv_vng_loc      = module.rg.resource_group_loc
    mv_vng_rg       = module.rg.resource_group_name
    mv_vng_sku      = var.op_vng_sku
    mv_vng_type     = var.op_vng_type
    mv_vng_vpn_type = var.op_vpn_type
    mv_vng_active_active = var.op_vng_active_active
    mv_vng_bgp           = var.op_vng_bgp
    mv_vng_publicip_address_id      = module.op_publicip.publicip_id
    mv_vng_gateway_subnetid          = module.op_subnet.subnet_id
}
