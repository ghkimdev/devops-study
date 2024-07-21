#!/bin/bash
sudo chown -R $USER:$GROUP /opt



# Install Sonarqube
cd /opt
sudo yum install -y unzip java-17-openjdk 
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.5.1.90531.zip
unzip sonarqube-10.5.1.90531.zip
mv sonarqube-10.5.1.90531 sonarqube
rm sonarqube-10.5.1.90531.zip

cat <<EOF | sudo tee /etc/systemd/system/sonarqube.service
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
User=vagrant
PermissionsStartOnly=true
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
StandardOutput=syslog
LimitNOFILE=131072
LimitNPROC=8192
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

sed -i "3i SONAR_JAVA_PATH=/usr/lib/jvm/java-17-openjdk-17.0.11.0.9-2.el8.x86_64/bin/java" /opt/sonarqube/bin/linux-x86-64/sonar.sh


# Start Sonarqube
sudo systemctl daemon-reload
sudo systemctl enable sonarqube
sudo systemctl start sonarqube

# Firewall open
sudo firewall-cmd --add-port=9000/tcp --permanent
sudo firewall-cmd --reload

