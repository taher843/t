resource "azurerm_virtual_network_gateway" "vnetgateway" {
  name                  =   var.mv_vng_name
  location              =   var.mv_vng_loc
  resource_group_name   =   var.mv_vng_rg
  sku                   =   var.mv_vng_sku
  type                  =   var.mv_vng_type
  vpn_type              =   var.mv_vng_vpn_type
  ip_configuration {
        name                            =   var.mv_publicip_gateway_config
        public_ip_address_id            =   var.mv_publicip_address_id
        private_ip_address_allocation   =   var.mv_publicip_add_alloc
        subnet_id                       =   var.mv_publicip_subnet
  }
}