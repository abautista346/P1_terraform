//LOAD BALANCER DEFINITION

resource "aws_lb" "loadB" {
  name               = "${var.environment}-load-balancer"
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.id_loadbalancer_sg]
  subnets            = [for subnet in var.public_subnets : subnet.id]

  enable_deletion_protection = true

  tags              = var.myTags
}

//Resource to connecting Load Balancer and Autoscaling group 
resource "aws_lb_target_group" "target_group_connect" {
  name     = "${var.environment}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

//listener HTTP
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.loadB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_connect.arn
  }
}

/*

//listener HTTPS
resource "aws_lb_listener" "lb_listener_https" {
  load_balancer_arn = aws_lb.loadB.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_connect.arn
  }
}
*/
