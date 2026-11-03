resource "azurerm_data_factory_pipeline" "raw_to_sql" {
  name            = "pl_raw_to_sql"
  data_factory_id = azurerm_data_factory.adf.id
  activities_json = file("${path.module}/pipeline_activities.json")

  depends_on = [
    azurerm_data_factory_dataset_delimited_text.raw_csv,
    azurerm_data_factory_dataset_azure_sql_table.sql_vivienda,
  ]
}
