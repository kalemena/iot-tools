VERSION := "1.8.16"
DEVICES := /dev/ttyUSB2

THIS_FILE := $(lastword $(MAKEFILE_LIST))

SHELL := /bin/bash

.PHONY: build

all: build

build:
	docker pull ubuntu:20.04
	docker build -t kalemena/arduino:${VERSION} src/main/docker/

arduino:
	bash ./arduino.sh ${DEVICES}

###########################
# BUILDING & PUBLISHING DOC

# Builds PDF book
doc.publishToPDF: 
	source docPublishingScripts.sh && publishPDF

# Builds PDF book
doc.publishToHTML: 
	source docPublishingScripts.sh && publishHTML

# Clean caches
doc.clean:
	rm -rf $(CURDIR)/build
	# docker run --rm -v $(CURDIR):/docs alpine rm -rf /docs/build