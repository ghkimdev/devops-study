#!/bin/bash

# Maven 설치 스크립트 for Ubuntu 20.04

# Step 1: 시스템 업데이트
echo "시스템 업데이트 중..."
sudo apt-get update -y

# Step 2: 필요한 패키지 설치
echo "필요한 패키지 설치 중..."
sudo apt-get install -y wget tar

# Step 3: Maven 다운로드
MAVEN_VERSION="3.9.6"
MAVEN_TAR="apache-maven-$MAVEN_VERSION-bin.tar.gz"
MAVEN_URL="https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/$MAVEN_TAR"
MAVEN_DIR="/opt/maven"

echo "Maven 다운로드 중..."
wget $MAVEN_URL -P /tmp

# Step 4: Maven 압축 해제 및 설치
echo "Maven 압축 해제 및 설치 중..."
sudo mkdir -p $MAVEN_DIR
sudo tar -zxvf /tmp/$MAVEN_TAR -C $MAVEN_DIR --strip-components=1

# Step 5: 환경 변수 설정
echo "환경 변수 설정 중..."
sudo tee /etc/profile.d/maven.sh > /dev/null <<EOF
export MAVEN_HOME=$MAVEN_DIR
export PATH=\$MAVEN_HOME/bin:\$PATH
EOF

# Step 6: 환경 변수 적용
echo "환경 변수 적용 중..."
source /etc/profile.d/maven.sh

# Step 7: Maven 버전 확인
echo "Maven 설치 완료! Maven 버전 확인:"
mvn -version

# Step 8: 설치 완료 메시지
echo "Maven 설치가 완료되었습니다!"

# 스크립트 종료
echo "설치 스크립트가 완료되었습니다."

