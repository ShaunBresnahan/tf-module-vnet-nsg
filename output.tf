output "virtual_network_name" {
  value = azurerm_virtual_network.spokevnet.name
}

output "network_security_group_id" {
  value = azurerm_network_security_group.nsg.id
}

output "network_security_group_name" {
  value = azurerm_network_security_group.nsg.name
}

# New output for route table module
output "subnet_ids" {
  description = "Map of subnet IDs keyed by subnet name"
  value       = { for name, subnet in azurerm_subnet.spokesubnet : name => subnet.id }
}