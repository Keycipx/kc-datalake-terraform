resource "azurerm_role_assignment" "companera_reader" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = var.companero_object_id
}

data "azurerm_policy_definition" "regiones" {
  display_name = "Allowed locations"
}

data "azurerm_policy_definition" "tipos" {
  display_name = "Allowed resource types"
}

resource "azurerm_resource_group_policy_assignment" "regiones_permitidas" {
  name                 = "regiones-permitidas"
  display_name         = "Solo East US 2 y Mexico Central"
  resource_group_id    = azurerm_resource_group.rg.id
  policy_definition_id = data.azurerm_policy_definition.regiones.id
  enforce              = true

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = ["eastus2", "mexicocentral"]
    }
  })
}

resource "azurerm_resource_group_policy_assignment" "tipos_permitidos" {
  name                 = "tipos-de-recurso-permitidos"
  display_name         = "Solo los tipos de recurso del proyecto"
  resource_group_id    = azurerm_resource_group.rg.id
  policy_definition_id = data.azurerm_policy_definition.tipos.id
  enforce              = true

  parameters = jsonencode({
    listOfResourceTypesAllowed = {
      value = [
        "Microsoft.Storage/storageAccounts",
        "Microsoft.Storage/storageAccounts/blobServices",
        "Microsoft.Storage/storageAccounts/blobServices/containers",
        "Microsoft.Sql/servers",
        "Microsoft.Sql/servers/databases",
        "Microsoft.Sql/servers/firewallRules",
        "Microsoft.DataFactory/factories",
        "Microsoft.DataFactory/factories/linkedservices",
        "Microsoft.DataFactory/factories/datasets",
        "Microsoft.DataFactory/factories/pipelines",
        "Microsoft.Consumption/budgets",
      ]
    }
  })
}

# Presupuesto mensual del resource group del proyecto, con alertas por correo.

resource "azurerm_consumption_budget_resource_group" "mensual" {
  name              = "presupuesto-datalake-mensual"
  resource_group_id = azurerm_resource_group.rg.id

  amount     = var.presupuesto_mensual
  time_grain = "Monthly"

  time_period {
    start_date = "2026-11-01T00:00:00Z"
  }

  notification {
    enabled        = true
    threshold      = 50
    operator       = "GreaterThan"
    threshold_type = "Actual"
    contact_emails = [var.correo_alertas]
  }

  notification {
    enabled        = true
    threshold      = 80
    operator       = "GreaterThan"
    threshold_type = "Actual"
    contact_emails = [var.correo_alertas]
  }

  notification {
    enabled        = true
    threshold      = 100
    operator       = "GreaterThan"
    threshold_type = "Forecasted"
    contact_emails = [var.correo_alertas]
  }
}