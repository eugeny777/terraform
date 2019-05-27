#!/usr/bin/env bash
docker swarm init
mkdir -p /etc/systemd/system/docker.service.d/
echo -e '[Service]\nExecStart=\nExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock'|tee -a /etc/systemd/system/docker.service.d/override.conf
systemctl daemon-reload
systemctl restart docker
