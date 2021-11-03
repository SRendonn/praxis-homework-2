#!/usr/bin/env bash
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
# reload systemd configuration
systemctl daemon-reload
# stop so the executable can be overwritten
systemctl --now disable go-server.service
# create /app dir where server will be placed
rm -rf /app
mkdir /app
cp -R /shared/server /app
# enable go-server.service on startup and start it with --now
systemctl --now enable go-server.service