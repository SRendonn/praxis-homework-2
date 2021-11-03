#!/usr/bin/env bash
# copy server binary from /shared directory to /app directory
# may skip this step
mkdir -p /app
cp -R /shared/server /app
# create systemd unit file for start on boot
cd /etc/systemd/system
echo "[Unit]" > go-server.service
echo "Description=Demo Go server." >> go-server.service
echo "[Service]" >> go-server.service
echo "Environment=\"PORT=$PORT\"" >> go-server.service
echo "Environment=\"IPSTACK_API_KEY=$IPSTACK_API_KEY\"" >> go-server.service
echo "ExecStart=/app/server/vuego-demoapp &" >> go-server.service
echo "[Install]" >> go-server.service
echo "WantedBy=multi-user.target" >> go-server.service
# enable go-server.service on startup and start it with --now
systemctl daemon-reload
systemctl --now enable go-server.service