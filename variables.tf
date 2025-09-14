variable "prefix" { 
  description = "Prefix added to the front of the nsg and vnet" 
}

variable "resource_group" {
  description = "resource group object resources will be added to"
  type = object({
    name         = string
    location     = string
  })
}

variable "address" {  
  description = "base address for subnets to be added"
}

variable "dns_servers" {
  description = "ips for dns server"
  default     = []
}

variable "subnets" {
  description = "Array of subnets. Each subnet can optionally have delegation."
  type = list(object({
    name               = string
    number             = number
    delegation_name    = optional(string)
    delegation_actions = optional(list(string))
    newbits            = optional(number)
  }))
}

variable "newbits" {
  default = 4
}

variable "service_endpoints" {  
  default = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.KeyVault"]
}

variable "tags" {
  type    = map(any)
  default = {}
}


###new


variable "ipam_pool_id" {
  description = "The ID of the IPAM pool to allocate from."
  type        = string
}

variable "auto_calculate_ip_count" {
  description = "If true, number_of_ip_addresses will be calculated from the IPAM pool CIDR."
  type        = bool
  default     = true
}

variable "number_of_ip_addresses" {
  description = "Manually set number of IP addresses to allocate (ignored if auto_calculate_ip_count = true)."
  type        = number
  default     = null
}

variable "ipam_pool_name" {
  description = "Name of the IPAM pool to allocate from."
  type        = string
}

variable "network_manager_id" {
  description = "The ID of the Network Manager that owns the IPAM pool."
  type        = string
}