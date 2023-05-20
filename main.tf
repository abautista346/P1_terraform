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

### command to use variables file 
# terraform apply -var-file="variables_values/val.tfvars"