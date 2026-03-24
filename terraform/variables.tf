variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-devops-project"
}

variable "location" {
  type        = string
  description = "Azure region for the resources"
  default     = "swedencentral"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VMs"
  default     = "azureuser"
}

variable "vm_size_master" {
  type        = string
  description = "Size of the Master VM"
  default     = "Standard_D2s_v3"
}

variable "vm_size_worker" {
  type        = string
  description = "Size of the Worker VM"
  default     = "Standard_D2s_v3"
}