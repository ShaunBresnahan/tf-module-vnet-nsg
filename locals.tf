locals {
  #base_cidr_block = var.address
  

  #new locls
  ipam_cidr           = try(data.azurerm_network_manager_ipam_pool.selected.address_prefixes[0], null)
  calculated_ip_count = local.ipam_cidr != null ? pow(2, 32 - tonumber(split("/", local.ipam_cidr)[1])) : null
  final_ip_count      = var.auto_calculate_ip_count && local.calculated_ip_count != null ? local.calculated_ip_count : var.number_of_ip_addresses
}
