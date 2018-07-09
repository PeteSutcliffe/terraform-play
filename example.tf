provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "example" {
  ami                    = "${lookup(var.amis, var.region)}"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]
  key_name               = "PeteKP"
}

#resource "aws_eip" "ip" {
#  instance = "${aws_instance.example.id}"
#}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
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

output "ip" {
  value = "${aws_instance.example.public_ip}"
}
