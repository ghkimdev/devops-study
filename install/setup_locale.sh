#!/bin/bash


cat <<EOF >> /etc/profile
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
EOF

source /etc/profile
