#!/bin/bash
sudo chown -R $USER:$GROUP /opt

mkdir -p /opt/mysqld_exporter/logs

# Install Mysqld Exporter
cd /opt/mysqld_exporter
wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.15.1/mysqld_exporter-0.15.1.linux-amd64.tar.gz
tar -xvf mysqld_exporter-0.15.1.linux-amd64.tar.gz --strip-components=1
rm mysqld_exporter-0.15.1.linux-amd64.tar.gz

cat <<EOF > mysqld_exporter.cnf
[client]
user=mysqld_exporter
password=StrongPassword
EOF

cat <<EOF > startup.sh
#!/bin/bash

# Start Mysqld Exporter
nohup /opt/mysqld_exporter/mysqld_exporter \
	--config.my-cnf /opt/mysqld_exporter/mysqld_exporter.cnf \
	--collect.global_status \
	--collect.info_schema.innodb_metrics \
	--collect.auto_increment.columns \
	--collect.info_schema.processlist \
	--collect.binlog_size \
	--collect.info_schema.tablestats \
	--collect.global_variables \
	--collect.info_schema.query_response_time \
	--collect.info_schema.userstats \
	--collect.info_schema.tables \
	--collect.perf_schema.tablelocks \
	--collect.perf_schema.file_events \
	--collect.perf_schema.eventswaits \
	--collect.perf_schema.indexiowaits \
	--collect.perf_schema.tableiowaits \
	--collect.slave_status \
	--web.listen-address=0.0.0.0:9104 > /opt/mysqld_exporter/logs/mysqld_exporter.log 2>&1 &
echo 'Mysqld Exporter started.'
EOF

cat <<EOF > shutdown.sh
#!/bin/bash

# Stop Mysqld Exporter
kill -15 \$(pgrep mysqld_exporter)
echo 'Mysqld Exporter stopped.'
EOF

chmod +x startup.sh
chmod +x shutdown.sh

# Firewall open
sudo firewall-cmd --add-port=9104/tcp --permanent
sudo firewall-cmd --reload

