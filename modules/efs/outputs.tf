output "efs_id" {
  value       = aws_efs_file_system.my_efs.id
  description = "Returns EFS ID "
}
