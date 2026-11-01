variable "location" {
  description = "Ubicacion de los recursos"
  type        = string
  default     = "East US 2"
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
  default     = "rg-kc-datalake"
}

variable "storage_account_name" {
  description = "Nombre del data lake storage"
  type        = string
  default     = "kcdatalake2026"
}

variable "environment" {
  description = "Ambiente del data lake"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "datalake-lab"
}

variable "sql_admin_login" {
  description = "Usuario administrador del SQL Server"
  type        = string
  default     = "sqladminkc"
}

variable "sql_admin_password" {
  description = "Contrasena del administrador de SQL"
  type        = string
  sensitive   = true
}

variable "my_ip" {
  description = "Tu IP publica para la regla de firewall"
  type        = string
}

variable "sql_location" {
  description = "Region para el SQL Server (puede diferir del resto)"
  type        = string
  default     = "mexicocentral"
}