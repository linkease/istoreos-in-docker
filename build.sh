#!/bin/sh
set -e

docker_build() {
	docker build \
		--build-arg ts="$(date)" \
		-t "$IMAGE":"$TAG" .
}

docker_build

