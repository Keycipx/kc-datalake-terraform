resource "azurerm_data_factory" "adf" {
  name                = "adf-kyc-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    institucion = "INIDE"
    componente  = "orquestacion"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "adf_to_lake" {
  scope                = azurerm_storage_account.adls.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_data_factory.adf.identity[0].principal_id
}