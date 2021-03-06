
data "azurerm_client_config" "current" {}

terraform {
    required_providers {
      azurerm = {
        version = "> 2.28" 
      }
    }
}

# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "main" {
    name     = format("%s-resourcegroup-%s",var.prefix,random_id.id.hex)
    location = var.region

    tags = merge(local.tags,{})

}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
    name                        = format("%sdiagstorage%s",var.prefix,random_id.id.hex)
    resource_group_name         = azurerm_resource_group.main.name
    location                    = azurerm_resource_group.main.location
    account_tier                = "Standard"
    account_replication_type    = "LRS"

    tags = merge(local.tags,{})
}


# Create Network Security Group and rule
resource "azurerm_network_security_group" "securitygroup" {
    name                = format("%s-securitygroup-%s",var.prefix,random_id.id.hex)
    location            = var.region
    resource_group_name = azurerm_resource_group.main.name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = merge(local.tags,{})

}

# Generate random text for a unique storage account name
resource "random_id" "id" {
    # keepers = {
    #     # Generate a new ID only when a new resource group is defined
    #     resource_group = azurerm_resource_group.resourcegroup.name
    # }
    
    byte_length = 2
}

locals {
    tags = merge(var.tags,{
        Terraform   = "true"
        Environment = var.environment
      }
    )
}