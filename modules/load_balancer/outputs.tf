output "target_lb" {
    value       = aws_lb_target_group.target_group_connect
    description = "Returns aws_lb_target_group used in Load Balancer"
}

