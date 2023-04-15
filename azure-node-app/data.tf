data "template_file" "vm_cloud_init_script" {
  template = file("./scripts/install-user-data.sh")
}