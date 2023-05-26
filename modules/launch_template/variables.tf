//Here will be set all the variables to get and to aply in main of this module


variable "environment" {
    description =   "value of my environment"
}

variable "ami_id" {
    description = "value of the AMI to use in launch template"
    validation {
        condition     = length(var.ami_id) > 4 && substr(var.ami_id, 0, 4) == "ami-"
        error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
    }
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

variable "arn_iam_profile" {
    description =   "arn value of the IAM Profile with access"
}

variable "sg_allow" {
    description =   "ID of Security Group from VPC"
}