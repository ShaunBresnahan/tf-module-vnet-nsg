# Terraform Module: for Azure vnet with nsg

## Required Resources

- `Resource Group` exists or is created external to the module.

## Usage

```terraform

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "MAIN_LOCATION" {
  description = "The location for the resource group."
  type        = string
}

variable "ProjectIdentity" {
  description = "Project identity prefix"
  type        = string
}

variable "MAIN_ADDRESS" {
  description = "Main address space"
  type        = string
}

variable "NEWBITS" {
  description = "New bits for subnetting"
  type        = number
}

variable "MAIN_ENDPOINTS" {
  description = "Service endpoints to associate with the subnets"
  type        = list(string)
}

variable "SUBNETS" {
  description = "List of subnets"
  type = list(object({
    name               = string
    number             = number
    delegation_name    = optional(string)
    delegation_actions = optional(list(string))
  }))
}

variable "DNS_SERVERS" {
  description = "List of DNS servers"
  type        = list(string)
}

module "alias" {
  source     = "./tf-module-vnet-nsg"
  providers = {
    azurerm.src = azurerm.something
  }
  resource_group    = data.azurerm_resource_group.rg
  prefix            = var.ProjectIdentity
  address           = var.MAIN_ADDRESS
  dns_servers       = var.DNS_SERVERS
  subnets           = var.SUBNETS
  newbits           = var.NEWBITS
  service_endpoints = var.MAIN_ENDPOINTS
}
```