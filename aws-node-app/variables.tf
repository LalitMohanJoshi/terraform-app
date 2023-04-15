variable "aws_region" {
  default = "ap-south-1"
}

variable "aws_subnet_region" {
  default = "ap-south-1a"
}

# Creating a Variable for ami of type map

variable "ec2_instance_count" {
  default = 1
}

variable "ec2_ami" {
  default = "ami-0d81306eddc614a45"
}

variable "ec2_ami_type" {
  default = "t2.micro"
}

variable "ec2_ins_name_prefix" {
  default = "node-app-ec2-instance"
}
