variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "kryst-nginx"
}

variable "location" {
  type        = string
  description = "Location of the resources"
  default     = "westeurope"
}

variable "admin_user" {
  type        = string
  description = "Name of the admin user"
  default     = "azureuser"
}

variable "ssh_pub_key" {
  type        = string
  description = "Value of the ssh-key"
  sensitive   = true
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID"
  sensitive   = true
}