// Here the modules will be invoked

module "vpc" {
    source                  =   "./modules/vpc"
    vpc_cidr                =   var.vpc_values["vpc_cidr"]
    #call values from diferent kinds of variables
    //vpc_cidr        =   var.cidr
    //vpc_cidr        =   var.vps_val.vpc_cidr
    environment             =   var.vpc_values["environment"]
    count_public_subnet     =   var.vpc_values["sn_public_nuber"]
    count_private_subnet    =   var.vpc_values["sn_priv_nuber"]
    cidr_open               =   var.vpc_values["open_all"]
}

module "launch_template" {
    source                  =   "./modules/launch_template"

    environment     =   var.vpc_values["environment"]
    ami_id          =   var.launch_template_values["ami_id"]
    instance_type   =   var.launch_template_values["instance_type"]
    name_device     =   var.launch_template_values["name_device"] 
    ebs_size        =   var.launch_template_values["ebs_size"] 
    bool_encript    =   var.launch_template_values["bool_encript"] 
    key_pair        =   var.launch_template_values["key_pair"]
}

### command to use variables file 
# terraform apply -var-file="variables_values/val.tfvars"