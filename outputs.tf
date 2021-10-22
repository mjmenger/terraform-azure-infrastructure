output resourcegroup_location {
    value = azurerm_resource_group.main.location
}

output resourcegroup_name {
    value = azurerm_resource_group.main.name
}

output private_subnet_ids {
    value = azurerm_subnet.private[*].id
}

output public_subnet_ids {
    value = azurerm_subnet.public[*].id
}

output management_subnet_ids {
    value = azurerm_subnet.management[*].id
}