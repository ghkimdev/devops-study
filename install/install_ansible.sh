#!/bin/bash

# 시스템 업데이트
sudo apt-get update
sudo apt-get upgrade -y

# Ansible PPA 추가 및 설치
sudo apt-get install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible

# 설치 확인
ansible --version

echo "Ansible 설치가 완료되었습니다."

