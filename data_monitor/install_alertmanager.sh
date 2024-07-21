#!/bin/bash
sudo chown -R $USER:$GROUP /opt

mkdir -p /opt/alertmanager/logs

# Install Alertmanager
cd /opt/alertmanager
wget https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz
tar -xvf alertmanager-0.27.0.linux-amd64.tar.gz --strip-components=1
rm alertmanager-0.27.0.linux-amd64.tar.gz

cat <<EOF > startup.sh
#!/bin/bash

# Start Alertmanager
nohup /opt/alertmanager/alertmanager --config.file=/opt/alertmanager/alertmanager.yml > /opt/alertmanager/logs/alertmanager.log 2>&1 &
echo 'Alertmanager started.'
EOF

cat <<EOF > shutdown.sh
#!/bin/bash

# Stop Alertmanager
kill -15 \$(pgrep alertmanager)
echo 'Alertmanager stopped.'
EOF

chmod +x startup.sh
chmod +x shutdown.sh


# Firewall open
sudo firewall-cmd --add-port=9093/tcp --permanent
sudo firewall-cmd --reload
