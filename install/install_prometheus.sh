#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install Prometheus
PROM_VERSION=2.45.5
wget https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz
tar -xvzf prometheus-${PROM_VERSION}.linux-amd64.tar.gz
sudo mv prometheus-${PROM_VERSION}.linux-amd64 /opt/prometheus
sudo useradd prometheus
sudo chown -R prometheus:prometheus /opt/prometheus
sudo echo '[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
ExecStart=/opt/prometheus/prometheus --config.file=/opt/prometheus/prometheus.yml --storage.tsdb.path=/opt/prometheus/data

[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/prometheus.service
sudo systemctl enable prometheus
sudo systemctl start prometheus

echo "Prometheus has been installed and started."

