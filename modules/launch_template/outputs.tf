

//Launch Template
output "id_launch_temp" {
    value       = aws_launch_template.launch_temp.id
    description = "Returns launch template ID "
}