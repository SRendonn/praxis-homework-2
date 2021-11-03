#!/usr/bin/env bash
yum install nginx -y

systemctl --now enable nginx