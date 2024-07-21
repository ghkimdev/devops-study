#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install Loki 

sudo apt update
sudo apt install -y loki promtail
sudo systemctl enable loki
sudo systemctl start loki

echo "Loki has been installed and started."

