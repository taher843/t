rg_name = "az-devops-rg"
loc_name = "eastus"
hub_vnet_name = "hub_vnet"
hub_vnet_add_space = ["10.0.0.0/16"]

#HubSubnet Config
hub_sub_name    =   "hub_subnet"
hub_sub_addpre  =   ["10.0.1.0/24"]

#Gateway Subnet Config
gateway_sub_name    =   "GatewaySubnet"
gateway_sub_addpre  =   ["10.0.2.0/24"]

#Op Vnet Config
op_vnet_name = "op_vnet"
op_vnet_add_space = ["192.168.0.0/16"]

#Op Subnet Config
op_sub_name    =   "op_subnet"
op_sub_addpre  =   ["192.168.1.0/24"]

#spoke 1 vnet config
spoke1_vnet_name = "az_spoke1_vnet"
spoke1_vnet_add_space = ["10.99.0.0/16"]

#Spoke1 Subnet Config
spoke1_sub_name    =   "spoke1_subnet"
spoke1_sub_addpre  =   ["10.99.1.0/24"]


#spoke 2 vnet config
spoke2_vnet_name = "az_spoke2_vnet"
spoke2_vnet_add_space = ["10.98.0.0/16"]

#Spoke 2 Subnet Config
spoke2_sub_name    =   "spoke2_subnet"
spoke2_sub_addpre  =   ["10.98.1.0/24"]

#spoke 3 vnet config
spoke3_vnet_name = "az_spoke3_vnet"
spoke3_vnet_add_space = ["10.97.0.0/16"]
spoke3_subnets        = "10.97.0.0/16"

#public IP
vng_publicip_name = "vnet-publicip"
vng_publicip_alloc_method = "Dynamic"