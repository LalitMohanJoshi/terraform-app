variable "oci_key" {
  default     = "./keys/oracleidentitycloudservice_private.pem"
  description = "private key to connect oci cloud"
}

# https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm#top

variable "oci_region" {
  default     = "ap-mumbai-1"
  description = "default region"
}

variable "oci_root_compartment_id" {
  default     = "ocid1.tenancy.oc1..aaaaaad4678468764aabf2u3k2h3npm4xevtg6vqshwao5hq65w7ff4bbxcwrtiklhoqzoa"
  description = "root compartement id"
}

# network-variables

variable "oci_vcn_cidr_block" {
  default     = "10.0.0.0/16"
  description = "Virtual Cloud Network CIDR Block"
}

variable "oci_vcn_private_subnet_cidr_block" {
  default     = "10.0.1.0/24"
  description = "Virtual Cloud Network Private Subnet CIDR Block"
}

variable "oci_vcn_public_subnet_cidr_block" {
  default     = "10.0.1.0/24"
  description = "Virtual Cloud Network Public Subnet CIDR Block"
}

# instance variables

variable "oci_availability_domain" {
  default     = "1"
  description = "availability domain count"
}

variable "oci_instance_count" {
  default = "1"
}

variable "oci_instance_vm_shape" {
  default = "VM.Standard.E2.1"
}

// See https://docs.us-phoenix-1.oraclecloud.com/images/
variable "instance_image_ocid" {
  default     = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaawjzckgb7f2wxc6sll6ryxsiuv26jjppryv5d2cnlimsm76n2c4vq"
  description = "pass the linux image OCID based on the Region"
}