output "instance_ami" {
  value = formatlist("%v", oci_core_instance.node_instance.*.public_ip)
}
