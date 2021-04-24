resource "azurerm_public_ip" "publicip" {
  name                  = var.mv_publicip_name
  location              = var.mv_publicip_loc
  resource_group_name   = var.mv_publicip_rg
  allocation_method     = var.mv_publicip_alloc_method
}