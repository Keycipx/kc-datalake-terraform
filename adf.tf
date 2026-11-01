resource "azurerm_data_factory" "adf" {
  name                = "adf-isaias-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}