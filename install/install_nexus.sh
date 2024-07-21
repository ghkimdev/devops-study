#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y
sudo apt install openjdk-11-jre -y

# Install Nexus
NEXUS_VERSION=3.68.1-02
wget https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-java11-unix.tar.gz
sudo tar -xvzf nexus-${NEXUS_VERSION}-java11-unix.tar.gz -C /opt
sudo mv /opt/nexus-${NEXUS_VERSION} /opt/nexus
sudo useradd nexus
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo sed -i 's/# INSTALL4J_JAVA_HOME_OVERRIDE=/INSTALL4J_JAVA_HOME_OVERRIDE=\/usr\/lib\/jvm\/java-11-openjdk-amd64/g' /opt/nexus/bin/nexus
sudo sed -i 's/#run_as_user=""/run_as_user="nexus"/g' /opt/nexus/bin/nexus.rc
sudo echo '[Unit]
Description=nexus service
After=network.target
  
[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop 
User=nexus
Restart=on-abort
TimeoutSec=600
  
[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/nexus.service

sudo systemctl enable nexus
sudo systemctl start nexus

echo "Nexus has been installed and started."
