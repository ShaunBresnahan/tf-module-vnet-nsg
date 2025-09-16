#resource "azurerm_virtual_network" "spokevnet" {
#  name                = "${var.prefix}-vnet"
#  provider            = azurerm.src
#  address_space       = [local.base_cidr_block]
#  location            = var.resource_group.location
#  resource_group_name = var.resource_group.name
#  dns_servers         = var.dns_servers
#  tags                = var.tags
#  lifecycle { ignore_changes = [tags] }
#}


#locals {
#  ipam_cidr           = try(data.azurerm_network_manager_ipam_pool.selected.address_prefixes[0], null)
#  calculated_ip_count = local.ipam_cidr != null ? pow(2, 32 - tonumber(split("/", local.ipam_cidr)[1])) : null
#  final_ip_count      = var.auto_calculate_ip_count && local.calculated_ip_count != null ? local.calculated_ip_count : var.number_of_ip_addresses
#}


#locals {
#  pool_cidr            = try(data.azurerm_network_manager_ipam_pool.selected.address_prefixes[0], null)
#  pool_calculated_ips  = local.pool_cidr != null ? pow(2, 32 - tonumber(split("/", local.pool_cidr)[1])) : null
#  desired_count        = var.prefix_length != null ? pow(2, 32 - var.prefix_length) : null
#
#  requested_ip_count = coalesce(
#    local.desired_count,                    # if you set desired_prefix_length (e.g., 24 -> 256)
#    (var.auto_calculate_ip_count ? local.pool_calculated_ips : null),  # else use pool size when auto=true
#    var.number_of_ip_addresses              # else manual fallback
#  )
#}




#locals {
#  final_ip_count = var.number_of_ip_addresses
#}


data "azurerm_network_manager_ipam_pool" "selected" {
  name               = var.ipam_pool_name
  network_manager_id = var.network_manager_id
}

  #number_of_ip_addresses = local.requested_ip_count
  #number_of_ip_addresses = local.final_ip_count
  
resource "azurerm_virtual_network" "spokevnet" {
  name                = "${var.prefix}-vnet"
  provider            = azurerm.src
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  dns_servers         = var.dns_servers
  tags                = var.tags

  ip_address_pool {
  id                     = data.azurerm_network_manager_ipam_pool.selected.id
  number_of_ip_addresses = var.number_of_ip_addresses 
}

  lifecycle {
    ignore_changes = [tags]
  }
}


####try next

#data "azurerm_network_manager_ipam_pool" "selected" {
#  name               = var.ipam_pool_name
#  network_manager_id = var.network_manager_id
#}
#
#resource "azurerm_virtual_network" "spokevnet" {
#  name                = "${var.prefix}-vnet"
#  provider            = azurerm.src
#  location            = var.resource_group.location
#  resource_group_name = var.resource_group.name
#  dns_servers         = var.dns_servers
#  tags                = var.tags
#
#  ip_address_pool {
#    id                     = data.azurerm_network_manager_ipam_pool.selected.id
#    number_of_ip_addresses = local.final_ip_count
#  }
#
#  lifecycle {
#    ignore_changes = [tags]
#  }
#}


