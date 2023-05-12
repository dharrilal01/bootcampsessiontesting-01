# General Variables 
variable "subscription_id_hub" {
  type = string
}
variable "subscription_id_spoke" {
  type = string
}
variable "app-name" {
  type        = string
  description = "Name to be used for resources in this Application"
}
variable "environment_tag" {
  type        = string
  description = "Environment tag value"
}
# Spoke vNet Variables 
variable "region1" {
  type        = string
  description = "location of the deployment"
}
variable "region1-vnet1-address-space" {
  type        = string
  description = "VNET address space for region 1 vnet"
}
variable "region1-vnet1-snet1-range" {
  type        = string
  description = "Subnet address space for region 1 subnet"
}
# Hub vWAN variables
variable "vwan-region1-hub1-prefix1" {
  type        = string
  description = "Address space for vWAN Location 1 Hub 1"
}
# VM Variables 
variable "vmfunc" {
  type        = string
  description = "vm functionality"
}
variable "vmsize" {
  type        = string
  description = "vm size"
}
variable "adminusername" {
  type        = string
  description = "admin username"
}
variable "adminpassword" {
  type        = string
  description = "admin password"
}