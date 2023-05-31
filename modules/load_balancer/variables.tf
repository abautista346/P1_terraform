variable "environment" {
    description =   "value of my environment"
}

variable "myTags" {
    description =   "All tags values"
}

variable "load_balancer_type" {
    description =   "set the kind of Load Balancer to launch"
}

variable "id_loadbalancer_sg" {
    description =   "Load Balancer's Security Group ID"
}

variable "public_subnets" {
    description =   "List of all Publi Subnets"
}

variable "vpc_id" {
    description =   "VPC ID"
}