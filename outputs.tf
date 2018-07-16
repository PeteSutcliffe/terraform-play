output "ip" {
  value = "${aws_instance.example.public_ip}"
}

output "loadbalancer_dns" {
  value = "${aws_elb.classic-elb.dns_name}"
}

output "alb_dns" {
  value = "${aws_lb.test.dns_name}"
}
