#!/bin/bash
sudo chown -R $USER:$GROUP /opt

mkdir -p /opt/prometheus/logs

# Install Prometheus
cd /opt/prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.45.5/prometheus-2.45.5.linux-amd64.tar.gz
tar -xvf prometheus-2.45.5.linux-amd64.tar.gz --strip-components=1
rm prometheus-2.45.5.linux-amd64.tar.gz

cat <<EOF > startup.sh
#!/bin/bash

# Start Prometheus
nohup /opt/prometheus/prometheus --config.file=/opt/prometheus/prometheus.yml > /opt/prometheus/logs/prometheus.log 2>&1 &
echo 'Prometheus started.'
EOF

cat <<EOF > shutdown.sh
#!/bin/bash

# Stop Prometheus
kill -15 \$(pgrep prometheus)
echo 'Prometheus stopped.'
EOF

chmod +x startup.sh
chmod +x shutdown.sh

# Firewall open
sudo firewall-cmd --add-port=9090/tcp --permanent
sudo firewall-cmd --reload

