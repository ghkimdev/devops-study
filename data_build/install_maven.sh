#!/bin/bash

sudo chown -R $USER:$GROUP /opt

# Install Maven
sudo yum install -y java-11-openjdk unzip

cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.zip
unzip apache-maven-3.8.8-bin.zip
rm apache-maven-3.8.8-bin.zip

echo "export MAVEN_HOME=/opt/apache-maven-3.8.8" >>~/.bash_profile
echo "export PATH=\$PATH:\$MAVEN_HOME/bin" >>~/.bash_profile
source ~/.bash_profile

