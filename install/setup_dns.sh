#!/bin/bash
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
sed -i 's/#DNS=/DNS=8.8.8.8/' /etc/systemd/resolved.conf

sudo systemctl restart systemd-resolved
