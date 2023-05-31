

//Launch Template
output "id_launch_temp" {
  value       = aws_launch_template.launch_temp.id
  description = "Returns launch template ID "
}

output "my_key" {
  value       = tls_private_key.my_key
  description = "KeyPair to use in all instances"
}
