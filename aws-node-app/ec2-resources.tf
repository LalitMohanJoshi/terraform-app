# define resource , that need to be create

resource "aws_key_pair" "terraform-demo-keys" {
  key_name   = "terraform-demo-key"
  public_key = file("./keys/putty_key.pub")

}

resource "aws_instance" "node-app-ec2" {
  # Creates multiple identical aws ec2 instances
  count = var.ec2_instance_count

  # All four instances will have the same ami and instance_type info
  ami           = var.ec2_ami
  instance_type = var.ec2_ami_type
  key_name      = aws_key_pair.terraform-demo-keys.key_name
  user_data     = file("./scripts/install_script.sh")

  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "${var.ec2_ins_name_prefix}-${count.index + 1}"
  }

  security_groups = ["${aws_security_group.node-app-security-group.id}"]
  subnet_id       = aws_subnet.node-app-subnet.id

  vpc_security_group_ids = [aws_security_group.node-app-security-group.id]

  # allow true if we want public ip addrees in subnet 
  associate_public_ip_address = true
}