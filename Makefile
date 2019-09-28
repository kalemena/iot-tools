
DEVICE_PORT := /dev/ttyUSB3
COMMAND_PROMPT := docker run -it --rm --device $(DEVICE_PORT):/dev/ttyUSB0 kalemena/arduino:latest

all: build

build:
	docker pull ubuntu:18.04
	docker build -t kalemena/arduino:latest .

arduino:
	bash ./arduino.sh