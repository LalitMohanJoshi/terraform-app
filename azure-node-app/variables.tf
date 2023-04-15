# auth credentials varables
variable "azure_app_subscription_id" {
  default = "d113f176-1794-1733-2892-23a784268408"
}

variable "azure_app_client_id" {
  default = "uiww8ZxjbWO9euKuHnR9JlHAoR54pMEn2lehKG25"
}

variable "azure_app_client_secret" {
  default = "NDeTOKHEXg4uqd72LCZaEdMekw9AEQFMYhvdYR8T"
}

variable "azure_app_tenant_id" {
  default = "bh8hKMlGW8CSrHboyOeRzye8u1HZ0Bu1qGCSy97k"
}

# vm config variables

variable "linux_vm_size" {
  default = "Standard_B2s"
}

variable "linux_vm_image_publisher" {
  default = "OpenLogic"
}

variable "linux_vm_image_offer" {
  default = "CentOS"
}

variable "centos_8_sku" {
  description = "SKU for latest CentOS 8 "
  default     = "8_5"
}

variable "linux_admin_username" {
  default = "azureuser"
}

variable "linux_admin_password" {
  default = "Welme@4514"
}