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

data "azurerm_network_manager_ipam_pool" "selected" {
  name               = var.ipam_pool_name
  network_manager_id = var.network_manager_id
}

locals {
  ipam_cidr           = try(data.azurerm_network_manager_ipam_pool.selected.address_prefixes[0], null)
  calculated_ip_count = local.ipam_cidr != null ? pow(2, 32 - tonumber(split("/", local.ipam_cidr)[1])) : null
  final_ip_count      = var.auto_calculate_ip_count && local.calculated_ip_count != null ? local.calculated_ip_count : var.number_of_ip_addresses
}

resource "azurerm_virtual_network" "spokevnet" {
  name                = "${var.prefix}-vnet"
  provider            = azurerm.src
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  dns_servers         = var.dns_servers
  tags                = var.tags

  ip_address_pool {
    id                     = data.azurerm_network_manager_ipam_pool.selected.id
    number_of_ip_addresses = local.final_ip_count
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

