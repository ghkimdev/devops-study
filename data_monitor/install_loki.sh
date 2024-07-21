#!/bin/bash
sudo chown -R $USER:$GROUP /opt

mkdir -p /opt/loki/logs

# Install Loki
cd /opt/loki
wget https://github.com/grafana/loki/releases/download/v3.0.0/loki-linux-amd64.zip
unzip loki-linux-amd64.zip
mv loki-linux-amd64 loki
rm loki-linux-amd64.zip

wget https://raw.githubusercontent.com/grafana/loki/main/cmd/loki/loki-local-config.yaml
mv loki-local-config.yaml loki-config.yaml

sed -i '39,40d' loki-config.yaml
sed -i 's/tmp/opt/g' loki-config.yaml

cat <<EOF > startup.sh
#!/bin/bash

# Start Loki
nohup /opt/loki/loki -config.file=/opt/loki/loki-config.yaml > /opt/loki/logs/loki.log 2>&1 &
echo 'Loki started.'
EOF

cat <<EOF > shutdown.sh
#!/bin/bash

# Stop Loki
kill -15 \$(pgrep loki)
echo 'Loki stopped.'
EOF

chmod +x startup.sh
chmod +x shutdown.sh

# Firewall open
sudo firewall-cmd --add-port=3100/tcp --permanent
sudo firewall-cmd --reload
