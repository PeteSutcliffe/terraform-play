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

