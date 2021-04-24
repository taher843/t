resource "azurerm_virtual_network" "vnet" {
  name                  = var.mv_vnet_name
  location              = var.mv_loc
  address_space         = var.mv_add_space
  resource_group_name   = var.mv_rgname
}