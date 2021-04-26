resource "azurerm_local_network_gateway" "lnetgateway" {
  name                = var.mv_lng_name
  resource_group_name = var.mv_lng_rg
  location            = var.mv_lng_loc
  gateway_address     = var.mv_lng_gateway_address
  address_space       = var.mv_lng_address_space
}