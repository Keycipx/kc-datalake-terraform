output "resource_group_name" {
  description = "Nombre del Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "Nombre del Storage Account"
  value       = azurerm_storage_account.adls.name
}

output "datalake_raw" {
  description = "Contenedor raw"
  value       = azurerm_storage_data_lake_gen2_filesystem.raw.name
}

output "datalake_processed" {
  description = "Contenedor processed"
  value       = azurerm_storage_data_lake_gen2_filesystem.processed.name
}

output "datalake_curated" {
  description = "Contenedor curated"
  value       = azurerm_storage_data_lake_gen2_filesystem.curated.name
}