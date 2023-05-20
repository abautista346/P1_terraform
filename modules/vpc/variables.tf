//Here will be set all the variables to get and to aply in main of ths module

variable "vpc_cidr" {
    description =   "CIDR value to my VPC"
}

variable "environment" {
    description =   "value of my environment"
}

variable "count_public_subnet" {
    description =   "number of public subnets to be created "
}

variable "count_private_subnet" {
    description =   "number of Private subnets to be created "
}

variable "cidr_open" {
    description =   "set 0.0.0.0/0 as a parameter "
}