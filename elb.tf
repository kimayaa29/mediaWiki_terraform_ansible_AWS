resource "aws_elb" "mw_elb" {
  name = "mediawiki-alb"
  security_groups = [aws_security_group.mw_elb_sg.id]
  subnets = [
    aws_subnet.mw_subnet_public_1.id,
    aws_subnet.mw_subnet_public_2.id
  ]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    interval = 30
    target = "HTTP:80/"
    timeout = 3
    unhealthy_threshold = 2
  }

  cross_zone_load_balancing = true
  idle_timeout = 100
  connection_draining = true
  connection_draining_timeout = 300

  tags = {
    "Name" = "mediawiki_elb"
  }
}

