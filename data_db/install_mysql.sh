#!/bin/bash


# Install Mysql
sudo yum install mysql mysql-server -y
sudo yum install mysql mysql-server -y
sudo systemctl start mysqld
sudo systemctl enable mysqld
sudo mysql_secure_installation 

sudo firewall-cmd --add-port=3306/tcp --permanent
sudo firewall-cmd --reload
