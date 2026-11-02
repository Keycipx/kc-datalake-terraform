resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "lake" {
  name                 = "ls_datalake"
  data_factory_id      = azurerm_data_factory.adf.id
  url                  = azurerm_storage_account.adls.primary_dfs_endpoint
  use_managed_identity = true
}

resource "azurerm_data_factory_linked_service_azure_sql_database" "sql" {
  name            = "ls_sql"
  data_factory_id = azurerm_data_factory.adf.id

  connection_string = "Server=tcp:${azurerm_mssql_server.sql.fully_qualified_domain_name},1433;Database=${azurerm_mssql_database.db.name};User ID=${var.sql_admin_login};Password=${var.sql_admin_password};Encrypt=true;Connection Timeout=30;"
}