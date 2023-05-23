//Here will be set all the variables to get and to aply in main of this module


variable "environment" {
    description =   "value of my environment"
}

variable "ami_id" {
    description = "value of the AMI to use in launch template"
}

variable "instance_type" {
    description = "value of the Instance Type to use in launch template"
}   

variable "name_device" {
    description = "value of the Name Device to use in launch template"
}

variable "ebs_size" {
    description = "value of the Size to use in launch template"
}

variable "bool_encript" {
    description = "bool to set encryptation in launch template"
}    
    
variable "key_pair" {
    description = "Key Pair name to use in the launch template"
}