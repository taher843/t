

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


module "publicip" {
  source = "./modules/publicip"
    mv_publicip_name            = var.vng_publicip_name
    mv_publicip_loc             = module.rg.resource_group_loc
    mv_publicip_rg              = module.rg.resource_group_name
    mv_publicip_alloc_method    = var.vng_publicip_alloc_method
}

module "vnetgateway" {
  source = "./modules/vnetgateway"
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
}
