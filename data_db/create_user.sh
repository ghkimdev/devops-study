#!/bin/bash

sudo mysql -u root -proot <<EOF

#CREATE USER 'mysqld_exporter'@'localhost' IDENTIFIED BY 'StrongPassword';

GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'mysqld_exporter'@'localhost';

FLUSH PRIVILEGES;
EOF
