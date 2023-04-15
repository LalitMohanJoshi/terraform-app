#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo yum install ec2-instance-connect
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl status httpd
sudo systemctl enable httpd
sudo usermod -a -G apache ec2-user
