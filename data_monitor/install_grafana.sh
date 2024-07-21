#!/bin/bash
sudo chown -R $USER:$GROUP /opt

mkdir -p /opt/grafana/logs

# Install Prometheus
cd /opt/grafana
wget https://dl.grafana.com/oss/release/grafana-11.0.0.linux-amd64.tar.gz
tar -zxvf grafana-11.0.0.linux-amd64.tar.gz --strip-components=1
rm grafana-11.0.0.linux-amd64.tar.gz

cat <<EOF > startup.sh
#!/bin/bash

# Start Grafana
nohup /opt/grafana/bin/grafana server --config=/opt/grafana/conf/defaults.ini > /opt/grafana/logs/grafana.log 2>&1 &
echo "Grafana started."
EOF

cat <<EOF > shutdown.sh
#!/bin/bash

# Stop Grafana
kill -15 \$(pgrep grafana)
echo 'Grafana stopped.'
EOF

chmod +x startup.sh
chmod +x shutdown.sh

# Firewall open
sudo firewall-cmd --add-port=3000/tcp --permanent
sudo firewall-cmd --reload

