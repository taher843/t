output "publicip_name" {
  value     = azurerm_public_ip.publicip.name
}

output "publicip_id" {
  value     = azurerm_public_ip.publicip.id
}

data "azurerm_public_ip" "publicip" {
  name                = azurerm_public_ip.publicip.name
  resource_group_name = var.mv_publicip_rg
}

output "public_ip_address" {
  value = "${data.azurerm_public_ip.publicip.ip_address}"
}