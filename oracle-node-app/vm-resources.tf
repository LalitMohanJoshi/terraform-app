resource "oci_core_instance" "node_instance" {
  count               = var.oci_instance_count
  compartment_id      = oci_identity_compartment.node_compartment.id
  availability_domain = "${lookup(data.oci_identity_availability_domains.node_availability_domains.availability_domains[var.oci_availability_domain - 1], "name")}"

  display_name = "node-app-instance-${count.index}"

  source_details {
    source_id   = var.instance_image_ocid
    source_type = "image"
  }
  shape = var.oci_instance_vm_shape

  create_vnic_details {
    subnet_id = oci_core_subnet.node_public_subnet.id

    display_name              = "node_primary_vnic"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "node-app-${count.index}"
  }

  metadata = {
    ssh_authorized_keys = data.template_file.oci_instance_ssh_public_key.rendered
    user_data           = "${base64encode(data.template_file.cloud-init-config.rendered)}"
  }

}