# Data sources allow Terraform to use information defined outside of Terraform

data "template_file" "cloud-init-config" {
  template = file("./scripts/cloud-init-config.sh")
}

data "template_file" "oci_instance_ssh_public_key" {
  template = file("./keys/putty_key.pub")
}

data "oci_identity_availability_domains" "node_availability_domains" {
  compartment_id = oci_identity_compartment.node_compartment.id
}
