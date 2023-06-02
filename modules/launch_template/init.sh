#!/bin/bash
sudo su

# Update environment
yum update -y

# Install Nginx
yum -y install nginx

#install NFS dependencies
yum install -y nfs-utils
yum install -y amazon-efs-utils

#mount EFS
mount -t efs -o tls ${efs_id_value}:/ /usr/share/nginx/html/

#start Nginx
systemctl start nginx

#install git
yum install -y git



##SOLO PARA PRUEBAS
mkdir /home/ec2-user/PRUEBA
echo ${key_pair} > /home/ec2-user/abautista-keypair.txt
chmod 600 /home/ec2-user/abautista-keypair.txt
#sudo sed -i 's/Welcome/ME SALIUUUU!/g' /usr/share/nginx/html/index.html

git clone https://github.com/CristianGarciaO/Consultoria-Informatica.git
rm -rf /usr/share/nginx/html/*
cp -frn Consultoria-Informatica/* /usr/share/nginx/html/ 


