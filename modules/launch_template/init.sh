#!/bin/bash
sudo su

# Update environment
yum update -y

# Install Nginx
yum -y install nginx

systemctl start nginx
mkdir /home/ec2-user/PRUEBA