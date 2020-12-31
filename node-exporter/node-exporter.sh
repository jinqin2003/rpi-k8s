#!/bin/bash
NODE_EXPORTER_VERSION="1.0.1"
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-arm64.tar.gz
tar -xzvf node_exporter-${NODE_EXPORTER_VERSION}.linux-arm64.tar.gz
cd node_exporter-${NODE_EXPORTER_VERSION}.linux-arm64
cp node_exporter /usr/local/bin

chown ubuntu:ubuntu /usr/local/bin/node_exporter

echo '[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=ubuntu
Group=ubuntu
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/node_exporter.service

# enable node_exporter in systemctl
systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter
