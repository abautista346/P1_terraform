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


