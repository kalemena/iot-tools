

VERSION := "1.8.10"
DEVICES := /dev/ttyUSB3

all: build

build:
	docker pull ubuntu:18.04
	docker build -t kalemena/arduino:${VERSION} .

arduino:
	bash ./arduino.sh ${DEVICES}