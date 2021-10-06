#in this template we are creating aws application laadbalancer and target group and alb http listener

resource "aws_alb" "alb" {
  #count           = var.use_api_gateway ? 0 : 1
  idle_timeout    = "30"
  name            = "myapp-load-balancer"
  security_groups = [aws_security_group.alb-sg.id]
  subnets         = aws_subnet.public.*.id
  
  tags            = {
    Name          = "myapp-load-balancer"
  }
  #tags            = merge(var.common_tags, var.tags)
}
 
resource "aws_alb_listener" "testapp" {
  #count = var.use_api_gateway ? 0 : 1
  default_action {
    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
    type = "redirect"
  }
 
  load_balancer_arn = aws_alb.alb.id
  port              = "80"
  protocol          = "HTTP"
}
 
resource "aws_alb_listener" "alb_listener_https" {
  #count           = var.use_api_gateway ? 0 : 1
  certificate_arn = "arn:aws:acm:us-west-2:122734987158:certificate/9c6d514d-8d54-4510-8524-cd8c4c066b85"
 
  default_action {
    target_group_arn = aws_alb_target_group.myapp-tg.arn
    type             = "forward"
  }
 
  load_balancer_arn = aws_alb.alb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
}
resource "aws_alb_target_group" "myapp-tg" {
  #count = var.use_api_gateway ? 0 : 1
  health_check {
    healthy_threshold   = "2"
    interval            = "6"
    matcher             = "200,301,302"
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = "2"
  }
 
  name       = "myapp-tg"
  port       = var.app_port
  protocol   = "HTTP"
  slow_start = "0"
 
  stickiness {
    cookie_duration = "86400"
    enabled         = "false"
    type            = "lb_cookie"
  }
 
  #tags = merge(var.common_tags, var.tags)
 
  target_type = "ip"
  vpc_id      = aws_vpc.test-vpc.id
}