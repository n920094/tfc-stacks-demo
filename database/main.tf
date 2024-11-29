locals {
  name = "${var.prefix}-db-${var.suffix}"
}

resource "azurerm_resource_group" "main" {
  name     = local.name
  location = var.location
}

module "avm-res-dbforpostgresql-flexibleserversql_server" {
  source  = "Azure/avm-res-dbforpostgresql-flexibleserver/azurerm"
  version = "0.1.2"
  #source  = "app.terraform.io/TED_EVAL/avm-res-dbforpostgresql-flexibleserver/azurerm"
  #version = "1.0.0"

  name                   = local.name
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  administrator_login    = "mradministrator"
  administrator_password = "P@ssw0rd12345!"
  sku_name               = "GP_Standard_D2ds_v4"
  create_mode            = "DefPointInTimeRestoreault"
  source_server_id       = module.avm-res-dbforpostgresql-flexibleserversql_server.pg_id
  tags                   = var.tags
}
