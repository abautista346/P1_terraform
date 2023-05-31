//set output values

//this is the First Public Subnet ID
output "public_subnet" {
    value       = aws_subnet.sn_public[0].id
    description = "Returns PUBLIC SN ID"
}

//Security Gruoup
output "id_sg_allow" {
    value       =   aws_security_group.allow_traffic.id
    description =   "ID of my Securuty Group to allow all"
}

//all public subnets
output "public_subnets" {
    value       = aws_subnet.sn_public
    description = "Returns ALL PUBLIC SUBNATES "
}

//all private subnets
output "private_subnets" {
    value       = aws_subnet.sn_private.*.id
    description = "Returns ALL PRIVATE SUBNATES ID "
}

//Security Gruoup to LOAD BALANCER
output "id_loadbalancer_sg" {
    value       =   aws_security_group.lb_securityG.id
    description =   "ID of Load Balancer Securuty Group"
}

//VPC ID
output "vpc_id" {
    value       =   aws_vpc.abautista_vpc.id
    description =   "VPC ID"
}