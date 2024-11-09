#!/bin/sh
set -e

docker_build() {
	docker build --build-arg ts="$(date)" -t "linkease/istoredup:0.1" .
}

docker_build

