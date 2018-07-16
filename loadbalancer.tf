resource "aws_elb" "classic-elb" {
  name               = "pete-terraform-elb"
  availability_zones = "${var.availabilityZones[var.region]}"

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
    target              = "http:80//healthcheck.html"
    interval            = 30
  }

  instances                   = ["${aws_instance.example.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "foobar-terraform-elb"
  }
}

resource "aws_lb" "test" {
  name               = "pete-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.pete_sg.id}"]
  subnets            = ["${data.aws_subnet.example.*.id}"]

  enable_deletion_protection = false

  tags {
    Owner = "pete"
  }
}

resource "aws_lb_target_group" "test" {
  name     = "pete-tf-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    interval = 30
    path     = "/healthcheck.html"
    matcher  = "200"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = "${aws_lb.test.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.test.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "test_attachment" {
  target_group_arn = "${aws_lb_target_group.test.arn}"
  target_id        = "${aws_instance.example.id}"
  port             = 80
}
