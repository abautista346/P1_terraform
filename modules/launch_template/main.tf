// here will be all the LAUNCH TEMLATE configuration 

// Local varable
locals {

  myTags = {
    Owner = "abautista"
    Env   = "p1"
  }

}

resource "aws_launch_template" "launch_temp" {
  name          = "${var.environment}_Launch_Template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.my_keypair.key_name

  //key_name               = var.key_pair
  update_default_version = true

  block_device_mappings {
    device_name = var.name_device

    ebs {
      volume_size = var.ebs_size
      encrypted   = var.bool_encript
    }
  }

  iam_instance_profile {
    arn = var.arn_iam_profile
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    device_index                = 0
    security_groups             = [var.sg_allow]
  }

  //user_data = data.template_file.script.rendered

  user_data = base64encode(data.template_file.script.rendered)

  tags = local.myTags

  depends_on = [aws_key_pair.my_keypair, data.template_file.script]
}


// resource to send vars to init.sh
data "template_file" "script" {
  template = file("${path.module}/init.sh")
  vars = {
    efs_id_value = "${var.efs_id}"
    key_pair     = "${tls_private_key.my_key.private_key_pem}"
  }
}


output "script" {
  value = data.template_file.script.rendered
}

/*
resource "null_resource" "name" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.my_key.private_key_pem
    host        = "35.92.38.113"
    timeout     = "20s"
  }

  provisioner "local-exec" {
    command = "sudo echo  ${tls_private_key.my_key.private_key_pem} > mykey.pem"
  }
}
*/

// Generate new private key
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
}

# Generate a key-pair with above key
resource "aws_key_pair" "my_keypair" {
  key_name   = "${var.environment}-keypair"
  public_key = tls_private_key.my_key.public_key_openssh
}
