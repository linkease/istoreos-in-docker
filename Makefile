.PHONY: build run clean

include istoreos.conf
export

build:
	./build.sh

run:
	./run.sh

clean:
	docker stop ${CONTAINER} || true
	docker rm ${CONTAINER} || true
	docker network rm ${LAN_NAME} ${WAN_NAME} || true
