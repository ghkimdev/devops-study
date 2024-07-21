#!/bin/bash
sudo chown -R $USER:$GROUP /opt

mkdir -p /opt/promtail/logs

# Install Promtail
cd /opt/promtail
wget https://github.com/grafana/loki/releases/download/v3.0.0/promtail-linux-amd64.zip
unzip promtail-linux-amd64.zip
mv promtail-linux-amd64 promtail
rm promtail-linux-amd64.zip

wget https://raw.githubusercontent.com/grafana/loki/main/clients/cmd/promtail/promtail-local-config.yaml
mv promtail-local-config.yaml promtail-config.yaml

cat <<EOF > startup.sh
#!/bin/bash

# Start Promtail
nohup /opt/promtail/promtail -config.file=/opt/promtail/promtail-config.yaml > /opt/promtail/logs/promtail.log 2>&1 &
echo 'Promtail started.'
EOF

cat <<EOF > shutdown.sh
#!/bin/bash

# Stop Promtail
kill -15 \$(pgrep promtail)
echo 'Promtail stopped.'
EOF

chmod +x startup.sh
chmod +x shutdown.sh

# Firewall open
sudo firewall-cmd --add-port=9080/tcp --permanent
sudo firewall-cmd --reload
