### values to send and set in the project


vpc_values = {
  vpc_cidr        = "12.0.0.0/16"
  environment     = "abautista"
  sn_public_nuber = 2
  sn_priv_nuber   = 3
  open_all        = "0.0.0.0/0"   
}


launch_template_values = {
  ami_id        = "ami-0ab193018f3e9351b"
  instance_type = "t2.micro"
  name_device   = "/dev/sdf"
  ebs_size      = 8
  bool_encript  = true
  key_pair      = "abautista_ssh_key"

}

auto_sacaling_values = {
  desired_capacity    =   3
  max_size            =   3
  min_size            =   1
}

load_balancer_values = {
  load_balancer_type = "application"

}
