output "instance_ami" {
  value = "${formatlist("%v", aws_instance.node-app-ec2.*.public_ip)}"
}
output "instance_arn" {
  value = "${formatlist("%v", aws_instance.node-app-ec2.*.private_ip)}"
}
