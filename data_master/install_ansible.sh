#!/bin/bash

# Ansible Install
sudo dnf update -y
sudo dnf install -y epel-release
sudo dnf install -y ansible

sudo chown -R $USER:$GROUP /etc/ansible

cat <<EOF >> /etc/ansible/hosts
[node]
192.168.56.11
192.168.56.12
192.168.56.13
192.168.56.14
EOF

# Ansible Install Check
ansible --version

