locals {
  app-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
yum install ansible -y
ansible-pull -U https://github.com/citb32/ansible-pull.git app.yml
USERDATA
}


resource "aws_launch_configuration" "appconfig" {
  name                      = "appconfig"
  image_id                  = "ami-094161bf15ab55a9c"
  instance_type             = "t2.micro"
  security_groups           = ["${var.security-group}"]
  key_name                  = "${var.keypairname}"
  user_data_base64          = "${base64encode(local.app-node-userdata)}"
}

resource "aws_autoscaling_group" "app-asg" {
  name                      = "student-app-asg"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.appconfig.name}"
  vpc_zone_identifier       = ["${var.public-subnets}"]
  load_balancers            = ["${aws_elb.studentapp-clb.name}"]
}


resource "aws_elb" "studentapp-clb" {
  name               = "studentapp-clb"
  availability_zones = ["${var.availability_zones}"]
  subnets           = ["${var.public-subnets}"]
  security_groups   = ["${var.security-group}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400

  tags {
    Name = "${var.proj-name}-clb"
  }
}