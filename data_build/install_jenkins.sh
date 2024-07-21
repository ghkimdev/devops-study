#!/bin/bash
JENKINS_HOME=/opt/jenkins
JAVA_HOME=/usr/lib/jvm/java-17-openjdk-17.0.11.0.9-2.el8.x86_64

sudo chown -R $USER:$GROUP /opt
mkdir -p $JENKINS_HOME

# Install jenkins
sudo yum install -y java-17-openjdk
cd /opt/jenkins
wget https://get.jenkins.io/war-stable/2.452.2/jenkins.war

cat <<EOL > $JENKINS_HOME/startup.sh
#!/bin/bash
export JENKINS_HOME=$JENKINS_HOME

nohup $JAVA_HOME/bin/java -jar $JENKINS_HOME/jenkins.war --httpPort=8080 > $JENKINS_HOME/jenkins.log 2>&1 &
EOL

cat <<EOL > $JENKINS_HOME/shutdown.sh
#!/bin/bash
pkill -f jenkins.war
EOL


chmod +x $JENKINS_HOME/startup.sh
chmod +x $JENKINS_HOME/shutdown.sh

cat <<EOF | sudo tee /etc/systemd/system/jenkins.service
[Unit]
Description=jenkins service
After=network.target

[Service]
Type=forking
ExecStart=$JENKINS_HOME/startup.sh
ExecStop=$JENKINS_HOME/shutdown.sh
User=vagrant
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF


# Start Jenkins
sudo systemctl daemon-reload
sudo systemctl enable jenkins.service
sudo systemctl start jenkins.service

# Firewall open
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload

