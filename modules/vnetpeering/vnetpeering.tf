resource "azurerm_virtual_network_peering" "vnet-peering-source" {
  name                  =               var.mv_source_peer_name
  resource_group_name   =               var.mv_source_rg_name
  virtual_network_name  =               var.mv_source_vnet_name
  remote_virtual_network_id =           var.mv_destination_vnet_id
  allow_virtual_network_access =        var.mv_allow_vnet_access
  allow_forwarded_traffic =             var.mv_allow_forwarded_traffic
  allow_gateway_transit =               var.mv_allow_gateway_transit
}

resource "azurerm_virtual_network_peering" "vnet-peering-destination" {
  name                  =               var.mv_destination_peer_name
  resource_group_name   =               var.mv_destination_rg_name
  virtual_network_name  =               var.mv_destination_vnet_name
  remote_virtual_network_id =           var.mv_source_vnet_id
  allow_virtual_network_access =        var.mv_allow_vnet_access
  allow_forwarded_traffic =             var.mv_allow_forwarded_traffic
  allow_gateway_transit =               var.mv_allow_gateway_transit
}