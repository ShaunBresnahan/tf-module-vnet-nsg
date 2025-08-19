output "subnets" {
  description = "Map of subnet resources created"
  value       = azurerm_subnet.spokesubnet
}

output "subnet_ids" {
  description = "Map of subnet IDs keyed by name"
  value       = { for k, s in azurerm_subnet.spokesubnet : k => s.id }
}
