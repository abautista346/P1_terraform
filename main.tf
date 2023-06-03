// Here the modules will be invoked

locals {

  myTags = {
    Owner = "abautista"
    Env   = "p1"
  }

}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_values["vpc_cidr"]
  #call values from diferent kinds of variables
  //vpc_cidr        =   var.cidr
  //vpc_cidr        =   var.vps_val.vpc_cidr
  environment          = var.vpc_values["environment"]
  count_public_subnet  = var.vpc_values["sn_public_nuber"]
  count_private_subnet = var.vpc_values["sn_priv_nuber"]
  cidr_open            = var.vpc_values["open_all"]
}

module "launch_template" {
  source = "./modules/launch_template"

  environment     = var.vpc_values["environment"]
  ami_id          = var.launch_template_values["ami_id"]
  instance_type   = var.launch_template_values["instance_type"]
  name_device     = var.launch_template_values["name_device"]
  ebs_size        = var.launch_template_values["ebs_size"]
  bool_encript    = var.launch_template_values["bool_encript"]
  key_pair        = var.launch_template_values["key_pair"]
  arn_iam_profile = module.role_definition.arn_iam_profile
  sg_allow        = module.vpc.id_sg_allow
  efs_id          = module.efs.efs_id

  depends_on = [module.efs]
}

module "role_definition" {
  source = "./modules/role_definition"

  environment = var.vpc_values["environment"]
  myTags      = local.myTags
}

module "auto_scaling" {
  source = "./modules/auto_scaling_group"

  environment      = var.vpc_values["environment"]
  myTags           = local.myTags
  private_subnets  = module.vpc.private_subnets
  id_launch_temp   = module.launch_template.id_launch_temp
  desired_capacity = var.auto_sacaling_values["desired_capacity"]
  max_size         = var.auto_sacaling_values["max_size"]
  min_size         = var.auto_sacaling_values["min_size"]
  target_lb        = module.load_balancer.target_lb

  depends_on = [module.launch_template]
}

module "load_balancer" {
  source = "./modules/load_balancer"

  environment        = var.vpc_values["environment"]
  myTags             = local.myTags
  load_balancer_type = var.load_balancer_values["load_balancer_type"]
  id_loadbalancer_sg = module.vpc.id_loadbalancer_sg
  public_subnets     = module.vpc.public_subnets
  vpc_id             = module.vpc.vpc_id


}

module "efs" {
  source = "./modules/efs"

  environment     = var.vpc_values["environment"]
  myTags          = local.myTags
  private_subnets = module.vpc.private_subnets
  id_sg_allow     = module.vpc.id_sg_allow
  //my_key          = module.launch_template.my_key
}


module "route53" {
  source = "./modules/route53"

  environment  = var.vpc_values["environment"]
  myTags       = local.myTags
  loadbalancer = module.load_balancer.Loadbalancer
}

output "output_values" {
  value = module.efs.efs_id
}

/*
output "output_script" {
  value = module.launch_template.script
}
*/
### command to use variables file 
# terraform apply -var-file="variables_values/val.tfvars"

### command to destroy an specific module
#   terraform destroy -target module.auto_scaling -var-file="variables_values/val.tfvars"

### I can Use "--auto-approve" to run and accept the changes without write a confirmation 
