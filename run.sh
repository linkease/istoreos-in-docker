#!/bin/bash

source istoreos.conf

docker network ls -f "name=docker-lan" | grep -q docker-lan || \
    docker network create -d bridge docker-lan

if ! docker inspect $IMAGE:$TAG >/dev/null 2>&1; then
	echo "no image '$IMAGE:$TAG' found, did you forget to run 'make build'?, build it"
	make build

elif docker inspect $CONTAINER >/dev/null 2>&1; then
	echo "* starting container '$CONTAINER'"
	docker start $CONTAINER || exit 1

else

# --privileged

docker create \
	--network $LAN_NAME \
	--cap-add NET_ADMIN \
	--cap-add NET_RAW \
	--hostname istoreos \
        -v /home/data/istoreos:/mnt/data \
	--sysctl net.netfilter.nf_conntrack_acct=1 \
	--sysctl net.ipv4.conf.all.forwarding=1 \
	--sysctl net.ipv6.conf.all.disable_ipv6=0 \
	--sysctl net.ipv6.conf.all.forwarding=1 \
	--name $CONTAINER $IMAGE:$TAG >/dev/null

docker start $CONTAINER

fi

