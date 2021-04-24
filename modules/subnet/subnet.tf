resource "azurerm_subnet" "subnet" {
  name                  =   var.mv_sub_name
  resource_group_name   =   var.mv_sub_rg
  address_prefixes      =   var.mv_sub_addpre
  virtual_network_name  =   var.mv_sub_vnet

}