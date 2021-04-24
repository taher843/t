terraform {
backend "azurerm"{
resource_group_name="devops" //Azure stroage account resource group.
storage_account_name="ironvpcsa" //Azure storage account name.
container_name="devops-container" //Storage account container name.
key="web.tfstate"
} 
required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.55.0"
    }
    }   
}
provider "azurerm" {
  features{}
  subscription_id = "e68a2996-7f24-4146-b740-f603c6f4492c"
  client_id       = "3ebebf97-0234-455c-bca9-c3c1d8fb3faf"
  client_secret   = "2OOkUFuYxtzAZ0ieBIzDRj98ZC-FRyAAVR"
  tenant_id       = "0c382db1-8285-4ecb-b9b7-021d0725e724"
}