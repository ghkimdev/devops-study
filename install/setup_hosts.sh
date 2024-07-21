#!/bin/bash

cat <<EOF > /etc/hosts
127.0.0.1	localhost

192.168.56.10 master01
192.168.56.11 build01
192.168.56.12 monitor01
192.168.56.13 web01
192.168.56.14 db01
EOF
