#!/bin/bash

apt -y install python3-pip python3.12-venv
python3 -m venv /root/proxy
/root/proxy/bin/python -m pip install proxy.py
cat >/etc/systemd/system/proxypy.service <<EOF
[Unit]
Description=ProxyPy
After=network.target

[Service]
ExecStart=/root/proxy/bin/python -m proxy --hostname 0.0.0.0 --port 9999
WorkingDirectory=/root/proxy
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now proxypy
