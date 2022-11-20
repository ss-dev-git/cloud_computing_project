resource "aws_lb" "lb" {
  name               = "${var.org_id}-web-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet.id ,aws_subnet.alb_sub2.id, aws_subnet.alb_sub1.id,]


  tags = merge(
    {
      "Name" = format("%s-web-loadbalancer", var.org_id)
    },
    local.web_tags
  )

}


resource "aws_lb_listener" "forward_https" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}

resource "aws_lb_listener_certificate" "listener_cert" {
  listener_arn    = aws_lb_listener.forward_https.arn
  certificate_arn = aws_acm_certificate.cert.arn
}

resource "aws_lb_target_group" "lb_tg" {
  name     = "${var.org_id}-web-lg-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.web_vpc.id
  health_check {
    path   = "/"
  }
  tags = merge(
    {
      "Name" = format("%s-web-lg-tg", var.org_id)
    },
    local.web_tags
  )
}

resource "aws_lb_target_group_attachment" "lbtg_attachment" {
  target_group_arn = aws_lb_target_group.lb_tg.arn
  target_id        = aws_instance.web.id
  port             = 80
}
