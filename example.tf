provider "aws" {
  region = "${var.region}"
}

data "template_file" "user_data" {
  template = "${file("app.tpl")}"
}

resource "aws_instance" "example" {
  ami                    = "${lookup(var.amis, var.region)}"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.pete_sg.id}"]
  key_name               = "PeteKP"
  user_data              = "${data.template_file.user_data.rendered}"
  iam_instance_profile   = "${aws_iam_instance_profile.pete_test_profile.name}"

  tags {
    Owner = "Pete"
  }
}

#resource "aws_eip" "ip" {
#  instance = "${aws_instance.example.id}"
#}

resource "aws_security_group" "pete_sg" {
  name        = "pete_sg"
  description = "Allow inbound http traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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

output "ip" {
  value = "${aws_instance.example.public_ip}"
}

output "loadbalancer_dns" {
  value = "${aws_elb.classic-elb.dns_name}"
}
