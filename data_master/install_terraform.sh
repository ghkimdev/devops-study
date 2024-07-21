#!/bin/bash

# 시스템 업데이트
sudo apt-get update
sudo apt-get upgrade -y

# 필요 패키지 설치
sudo apt-get install -y gnupg software-properties-common curl

# HashiCorp GPG 키 추가
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# HashiCorp 리포지토리 추가
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Terraform 설치
sudo apt-get update
sudo apt-get install -y terraform

# 설치 확인
terraform --version

echo "Terraform 설치가 완료되었습니다."

