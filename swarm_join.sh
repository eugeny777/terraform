#!/usr/bin/env bash
yum install epel-release -y
yum install jq -y
TOKEN=$(curl -s swarm_master:2376/swarm |jq '."JoinTokens"."Worker"'|tr -d \"); docker swarm join  --token $TOKEN docker_master
