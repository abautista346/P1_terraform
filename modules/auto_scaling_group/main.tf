//HERE IS THE AUTO SCALING GROUP USING LAUNCH TEMPLATE

resource "aws_autoscaling_group" "auto_scaling" {
  name                  =   "${var.environment}-AutoScalingG"

  desired_capacity      =   var.desired_capacity
  max_size              =   var.max_size
  min_size              =   var.min_size
  vpc_zone_identifier   =   var.private_subnets

  launch_template {
    id      = var.id_launch_temp
    version = "$Latest"
  }

  target_group_arns = [var.target_lb.arn] 
  

  dynamic "tag" {
    for_each = var.myTags
    content {
      key                 = tag.key
      propagate_at_launch = true
      value               = tag.value
    }
  }

}