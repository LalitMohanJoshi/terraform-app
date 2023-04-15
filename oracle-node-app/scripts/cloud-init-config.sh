#! /bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd
echo "<h1>Oracle Virtual Machine Working</h1>" | sudo tee /var/www/html/index.html
netstat -ntlp

# enable ports in firewall

# sudo firewall-cmd --zone=public --permanent --add-port=80/tcp --add-port=443/tcp
# sudo firewall-cmd --reload
# sudo firewall-cmd --info-zone public