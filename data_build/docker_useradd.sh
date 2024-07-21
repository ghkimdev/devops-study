#!bin/bash

# Create the docker group and add user
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

