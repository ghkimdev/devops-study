#!/bin/bash
sudo chown -R $USER:$GROUP /opt

mkdir -p /opt/blackbox_exporter/logs

# Install Blackbox Exporter
cd /opt/blackbox_exporter
wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.25.0/blackbox_exporter-0.25.0.linux-amd64.tar.gz
tar -xvf blackbox_exporter-0.25.0.linux-amd64.tar.gz --strip-components=1
rm blackbox_exporter-0.25.0.linux-amd64.tar.gz

cat <<EOF > startup.sh
#!/bin/bash

# Start Blackbox Exporter
nohup /opt/blackbox_exporter/blackbox_exporter > /opt/blackbox_exporter/logs/blackbox_exporter.log 2>&1 &
echo 'Blackbox Exporter started.'
EOF

cat <<EOF > shutdown.sh
#!/bin/bash

# Stop Blackbox Exporter
kill -15 \$(pgrep blackbox_exporter)
echo 'Blackbox Exporter stopped.'
EOF

chmod +x startup.sh
chmod +x shutdown.sh

# Firewall open
sudo firewall-cmd --add-port=9115/tcp --permanent
sudo firewall-cmd --reload

