////////// voy a necesitar ejecutar el EFS en la misma AVAILABILITY ZONE que las instanicas
///////// tambien necesitare establecer un SECURITY GROUP
//////// en teoria tambien hay que habilitar algo de la DNS para poder enlazarlo 

resource "aws_efs_file_system" "my_efs" {
  creation_token = "${var.environment}-efs"
  tags           = merge(var.myTags, { Name = "${var.environment}-EFS" })
}

# Creating Mount target of EFS
resource "aws_efs_mount_target" "mount" {
  count = length(var.private_subnets)

  file_system_id  = aws_efs_file_system.my_efs.id
  subnet_id       = var.private_subnets[count.index]
  security_groups = [var.id_sg_allow]
}

/*
# Creating Mount Point for EFS
resource "null_resource" "configure_nfs" {

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = var.my_key.private_key_pem
    host        = aws_instance.web.public_ip
  }

  depends_on = [aws_efs_mount_target.mount]

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd php git -y -q ",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo yum install nfs-utils -y -q ", # Amazon ami has pre installed nfs utils
      # Mounting Efs 
      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html",
      # Making Mount Permanent
      "echo ${aws_efs_file_system.efs.dns_name}:/ /var/www/html nfs4 defaults,_netdev 0 0  | sudo cat >> /etc/fstab ",
      "sudo chmod go+rw /var/www/html",
      "sudo git clone https://github.com/Apeksh742/EC2_instance_with_terraform.git /var/www/html",
    ]
  }
}
*/
