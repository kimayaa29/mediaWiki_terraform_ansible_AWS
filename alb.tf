resource "aws_lb" "mw_alb" {
  name = "mediawiki_alb"
  load_balancer_type = "application"
  subnets = [aws_subnet.mw_subnet.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.mw_alb.arn
  port = 80
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: PAGE NOT FOUND"
      status_code = "404"
    }
  }
}

resource "aws_security_group" "mw_alb_sg" {
  vpc_id = aws_vpc.mw_vpc.id
  name = "mediawiki_alb_sg"

  ingress {
    from_port = 80
    protocol = "TCP"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
