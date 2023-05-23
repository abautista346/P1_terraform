//variable that recibe values to send in main.tf

//to VPC ---- this values are on the ./variables_values/val.tfvalues
variable "vpc_values" {
    description =   "Set variables for the VPC module"
}

//one variable  ---- normal variable
variable "cidr" {
    type    = string
    default = "12.0.0.0/16"
}

//variable with some values
variable "vps_val" {
    type = list(object({

        vpc_cidr    = string
        environment = string

    }))
    default = [
    {
        vpc_cidr    = "12.0.0.0/16"
        environment = "abautista"
    }
  ]
}


//to launch_template MODULE
variable "launch_template_values" {
    description =   "values to set configuration in Launch Template"
}