#!/bin/bash

sudo yum update -y
sudo yum install httpd -y
sudo service httpd start
echo "Hello world" >> /var/www/html/index.html