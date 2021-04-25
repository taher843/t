resource "azurerm_virtual_network_gateway" "vnetgateway" {
  name                = var.mv_vng_name
  resource_group_name = var.mv_vng_rg
  location            = var.mv_vng_loc

  type     = var.mv_vng_type
  vpn_type = var.mv_vng_vpn_type

  sku           = var.mv_vng_sku
  active_active = var.mv_vng_active_active
  enable_bgp    = var.mv_vng_bgp

  ip_configuration {
    subnet_id            = var.mv_vng_gateway_subnetid
    public_ip_address_id = var.mv_vng_publicip_address_id
  }
}