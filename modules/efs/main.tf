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

resource "aws_efs_access_point" "my_access_point" {
  file_system_id = aws_efs_file_system.my_efs.id
  root_directory {
    path = "/usr/share/nginx/html"
    creation_info {
      owner_gid   = "1000"
      owner_uid   = "1000"
      permissions = "755"
    }
  }

  tags = merge(var.myTags, { Name = "${var.environment}-EFS-accesspoint" })
}

