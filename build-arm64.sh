#!/bin/sh
set -e

docker_build() {
	docker buildx build --platform linux/arm64 -t linkease/istoreduprk35xx:0.1 -f ./Dockerfile --push .
}

docker_build

