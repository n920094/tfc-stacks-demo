locals {
  name = "${var.prefix}-db-${var.suffix}"
}

resource "azurerm_resource_group" "main" {
  name     = local.name
  location = var.location
}

module "sql_server" {
  source  = "Azure/avm-res-dbformysql-flexibleserver/azurerm"
  version = "0.1.0"

  name                   = local.name
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  administrator_login    = "mradministrator"
  administrator_password = "P@ssw0rd12345!"
  sku_name               = "GP_Standard_D2ds_v4"
  server_version         = "16"
  tags                   = var.tags

  /*
  name                   = local.name
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  administrator_login    = "mradministrator"
  administrator_password = "P@ssw0rd12345!"
  sku_name               = "GP_Standard_D2ds_v4"
  create_mode            = "Update"

  tags = var.tags
  */
}
