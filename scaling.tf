resource "aws_launch_configuration" "mw_launch_config" {
  image_id = var.ami
  instance_type = var.instance-type
  security_groups = [aws_security_group.mw_sg.id]
  user_data = data.template_file.user_data.rendered
  key_name = var.key_name
  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "user_data" {
  template = file("prereq.tpl")
}

resource "aws_autoscaling_group" "mw_asg" {
  name = "${aws_launch_configuration.mw_launch_config.name}-asg"
  max_size = 3
  min_size = 1
  health_check_type = "ELB"
  load_balancers = [
    aws_elb.mw_elb.id
  ]
  launch_configuration = aws_launch_configuration.mw_launch_config.name
  vpc_zone_identifier = [
    aws_subnet.mw_subnet_public_1.id,
    aws_subnet.mw_subnet_public_2.id
  ]
  tag {
    key = "Name"
    propagate_at_launch = true
    value = "mediawiki_asg"
  }
}

