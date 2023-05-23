### values to send and set in the project


vpc_values = {
  vpc_cidr        = "12.0.0.0/16"
  environment     = "abautista"
  sn_public_nuber = 1
  sn_priv_nuber   = 3
  open_all        = "0.0.0.0/0"   
}


launch_template_values = {
  ami_id        = "ami-04e914639d0cca79a"
  instance_type = "t2.micro"
  name_device   = "/dev/sda1"
  ebs_size      = 8
  bool_encript  = true
  key_pair      = "abautista_ssh_key"
  
}
