VERSION := "1.8.13"
DEVICES := /dev/ttyUSB2

all: build

build:
	docker pull ubuntu:20.04
	docker build -t kalemena/arduino:${VERSION} src/main/docker/

arduino:
	bash ./arduino.sh ${DEVICES}
