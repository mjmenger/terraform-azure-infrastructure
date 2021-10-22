output resourcegroup_location {
    value = azurerm_resource_group.main.location
}

output resourcegroup_name {
    value = azurerm_resource_group.main.name
}

output private_subnet_ids {
    value = data.azurerm_subnet.internal[*].id
}

output public_subnet_ids {
    value = data.azurerm_subnet.external[*].id
}

output management_subnet_ids {
    value = data.azurerm_subnet.mgmt[*].id
}