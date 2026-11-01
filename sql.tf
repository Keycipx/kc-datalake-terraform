resource "azurerm_mssql_server" "sql" {
  name                         = "sql-kc-${random_string.sql_suffix.result}"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.sql_location 
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

resource "azurerm_mssql_database" "db" {
  name        = "db-curated"
  server_id   = azurerm_mssql_server.sql.id
  sku_name    = "Basic"
  max_size_gb = 2

  tags = {
    environment = var.environment
    project     = var.project_name
  }

  storage_account_type = "Local"
}

# servicios de Azure (como Data Factory) se conecten
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# computadora se conecte (Power BI, Python, R, VS Code)
resource "azurerm_mssql_firewall_rule" "allow_my_ip" {
  name             = "AllowMyIP"
  server_id        = azurerm_mssql_server.sql.id
  start_ip_address = var.my_ip
  end_ip_address   = var.my_ip
}