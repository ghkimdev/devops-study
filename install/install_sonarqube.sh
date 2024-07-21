#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install SonarQube
SONAR_VERSION=9.6.1.59531
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-${SONAR_VERSION}.zip
sudo apt install -y unzip
sudo unzip sonarqube-${SONAR_VERSION}.zip -d /opt
sudo mv /opt/sonarqube-${SONAR_VERSION} /opt/sonarqube
sudo useradd sonar --system 
sudo chown -R sonar:sonar /opt/sonarqube
sudo sed -i '2i\SONAR_JAVA_PATH=/usr/lib/jvm/java-11-openjdk-amd64/bin/java' /opt/sonarqube/bin/linux-x86-64/sonar.sh

#sudo sed -i 's/# INSTALL4J_JAVA_HOME_OVERRIDE=/SONAR_JAVA_HOME_OVERRIDE=\/usr\/lib\/jvm\/java-11-openjdk-amd64/g' /opt/sonarqube/bin/linux-x86-64/sonar.sh
sudo echo '[Unit]
Description=SonarQube service
After=network.target

[Service]
Type=simple
User=sonar
Group=sonar
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
PermissionsStartOnly = true
Restart=always

StandardOutput=syslog
LimitNOFILE=131072
LimitNPROC=8192
TimeoutStartSec=5
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/sonarqube.service
sudo systemctl enable sonarqube
sudo systemctl start sonarqube

echo "SonarQube has been installed and started."

