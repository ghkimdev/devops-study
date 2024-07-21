#!/bin/bash

sudo firewall-cmd --add-port=9090/tcp
sudo firewall-cmd --add-port=3000/tcp
sudo firewall-cmd --add-port=3100/tcp
sudo firewall-cmd --add-port=9100/tcp
sudo firewall-cmd --add-port=9115/tcp
sudo firewall-cmd --reload

