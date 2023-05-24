// here will be all the LAUNCH TEMLATE configuration 

// Local varable
locals {
  
  myTags = {
    Owner   =   "abautista"
    Env     =   "p1"
  }

}

resource "aws_launch_template" "launch_temp" {
  name                      =   "${var.environment}_Launch_Template"
  image_id                  =   var.ami_id
  instance_type             =   var.instance_type
  key_name                  =   var.key_pair
  update_default_version    =   true

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

  tags        = local.myTags 
}


