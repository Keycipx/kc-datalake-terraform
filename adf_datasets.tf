resource "azurerm_data_factory_dataset_delimited_text" "raw_csv" {
  name                = "ds_raw_csv"
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_data_lake_storage_gen2.lake.name

  azure_blob_fs_location {
    file_system = "raw"
    path        = "emnv14"
    filename    = "Datos de la vivienda y el hogar.csv"
  }

  column_delimiter    = ","
  encoding            = "UTF-8"
  first_row_as_header = true
}
