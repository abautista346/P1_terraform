#!/bin/bash
yum install -y nginx
systemctl start nginx
mkdir /home/ec2-user/PRUEBA