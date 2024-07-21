#!/bin/bash
sudo chown -R $USER:$GROUP /opt

mkdir -p /opt/node_exporter/logs

# Install Node Exporter
cd /opt/node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz
tar -xvf node_exporter-1.8.1.linux-amd64.tar.gz --strip-components=1
rm node_exporter-1.8.1.linux-amd64.tar.gz

cat <<EOF > startup.sh
#!/bin/bash

# Start Node Exporter
nohup /opt/node_exporter/node_exporter > /opt/node_exporter/logs/node_exporter.log 2>&1 &
echo 'Node Exporter started.'
EOF

cat <<EOF > shutdown.sh
#!/bin/bash

# Stop Node Exporter
kill -15 \$(pgrep node_exporter)
echo 'Node Exporter stopped.'
EOF

chmod +x startup.sh
chmod +x shutdown.sh

# Firewall open
sudo firewall-cmd --add-port=9100/tcp --permanent
sudo firewall-cmd --reload
