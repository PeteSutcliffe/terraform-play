#!/bin/bash

sudo yum update -y
sudo yum install httpd -y
sudo service httpd start
chkconfig httpd on
echo "Hello world" >> /var/www/html/index.html
echo "Healthy" >> /var/www/html/healthcheck.html