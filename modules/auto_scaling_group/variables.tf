
variable "environment" {
    description =   "value of my environment"
}

variable "myTags" {
    description =   "All tags values"
}

variable "id_launch_temp" {
    description =   "ID of Launch Template"
}

variable "private_subnets" {
    description =   "Array of all rivate subnets"
}

variable "desired_capacity" {
    description =   "Number of Amazon EC2 instances that should be running in the group"
}

variable "max_size" {
    description =   "Maximum size of the Auto Scaling Group"
}

variable "min_size" {
    description =   "Minimum number of instances to maintain in the warm pool"
}

variable "target_lb" {
    description =   "Target Group used in Load Balancer"
}