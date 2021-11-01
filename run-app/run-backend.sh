#!/usr/bin/env bash
# copy server binary from /shared directory to /app directory
# may skip this step
mkdir -p /app/go-server
cp /shared/server /app/go-server
cd /app/go-server
# run the binary, & makes it run in the background
./vuego-demoapp &
