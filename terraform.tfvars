# Core Variables
app-name                  = "oag-prod"
environment_tag           = "prod"
region1                   = "canadacentral"
subscription_id_hub       = "4dfb599e-8459-4600-86a9-a19faa01ad6d"
subscription_id_spoke     = "07e2424a-029a-4ae7-b114-d91306b23f5b"

# Spoke Networking
region1-vnet1-address-space = "10.10.8.0/21"
region1-vnet1-snet1-range   = "10.10.11.0/24"

# vWAN
vwan-region1-hub1-prefix1 = "10.10.0.0/21"

# VMs
vmfunc        = "testing"
vmsize        = "Standard_B4ms"
adminusername = "oagadmin"
adminpassword = "O@gadmin!23"