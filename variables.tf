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