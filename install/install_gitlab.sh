#!/bin/bash

# 시스템 업데이트
sudo apt-get update
sudo apt-get upgrade -y

# 필수 패키지 설치
sudo apt-get install -y curl openssh-server ca-certificates tzdata perl

# GitLab 패키지 저장소 추가 및 설치
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo EXTERNAL_URL="http://192.168.56.10" apt-get install -y gitlab-ce

# GitLab 설정
sudo gitlab-ctl reconfigure

# 상태 확인
sudo gitlab-ctl status

echo "GitLab CE 설치가 완료되었습니다."
echo "웹 브라우저를 열고 http://192.168.56.10 에 접속하여 초기 설정을 완료하세요."

