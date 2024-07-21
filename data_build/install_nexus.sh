#!/bin/bash
sudo chown -R $USER:$GROUP /opt

# Install Nexus
sudo yum install -y java-11-openjdk
cd /opt
wget https://download.sonatype.com/nexus/3/nexus-3.69.0-02-java11-unix.tar.gz
tar -xzf nexus-3.69.0-02-java11-unix.tar.gz
mv nexus-3.69.0-02 nexus
rm nexus-3.69.0-02-java11-unix.tar.gz

sed -i "s/# INSTALL4J_JAVA_HOME_OVERRIDE=/INSTALL4J_JAVA_HOME_OVERRIDE=\/usr\/lib\/jvm\/java-11-openjdk-11.0.23.0.9-3.el8.x86_64/g" /opt/nexus/bin/nexus
sed -i "s/#run_as_user= ""/run_as_user="vagrant"" /opt/nexus/bin/nexus.rc

cat <<EOF | sudo tee /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=vagrant
Restart=on-abort
TimeoutSec=600

[Install]
WantedBy=multi-user.target
EOF

# Start Nexus
sudo systemctl daemon-reload
sudo systemctl enable nexus.service
sudo systemctl start nexus.service

# Firewall open
sudo firewall-cmd --add-port=8081/tcp --permanent
sudo firewall-cmd --reload

