#!/bin/bash


source openwrt.conf

docker create \
	--privileged \
	--network $LAN_NAME \
	--cap-add NET_ADMIN \
	--cap-add NET_RAW \
	--hostname openwrt \
	--sysctl net.netfilter.nf_conntrack_acct=1 \
	--sysctl net.ipv6.conf.all.disable_ipv6=0 \
	--sysctl net.ipv6.conf.all.forwarding=1 \
	--name $CONTAINER $IMAGE:$TAG >/dev/null

docker start $CONTAINER

