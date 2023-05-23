//set output values

//this is the First Public Subnet ID
output "public_subnet" {
    value       = aws_subnet.sn_public[0].id
    description = "Returns PUBLIC SN ID"
}


