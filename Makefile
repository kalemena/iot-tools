VERSION := 1.8.19
DEVICE := /dev/ttyUSB1

DOCKER_BUILD_OPTS := --pull
BUILD_DATE := `date -u +"%Y-%m-%dT%H:%M:%SZ"`
TAG_DATE := `date -u +"%Y-%m-%d"`
VCS_REF := `git rev-parse --short HEAD`

THIS_FILE := $(lastword $(MAKEFILE_LIST))

SHELL := /bin/bash

.PHONY: build

all: build

build: build-atmega build-esp8266 build-esp32
	@echo DONE building images

# make build-atmega
# make build-esp8266
# make build-esp32
build-%: 
	@echo "Building docker image ${VERSION}-$*"
	docker build ${DOCKER_BUILD_OPTS} \
		--build-arg BUILD_DATE=${BUILD_DATE} \
        --build-arg VCS_REF=${VCS_REF} \
        --build-arg VERSION=${VERSION} \
		-t kalemena/arduino:${VERSION}-$*-${TAG_DATE} \
		src/main/docker/boards/$*
	docker tag ${IMAGE}:${VERSION}-$*-${TAG_DATE} ${IMAGE}:${VERSION}-$*-latest

push: push-atmega push-esp8266 push-esp32

# make push-atmega
# make push-esp8266
# make push-esp32
push-%:
	docker push ${IMAGE}:${VERSION}-$*-${TAG_DATE}
    docker push ${IMAGE}:${VERSION}-$*-latest
	
# make arduino-atmega
# make arduino-esp8266
# make arduino-esp32
arduino-%:
	bash ./arduino.sh $* ${DEVICE}

###########################
# BUILDING & PUBLISHING DOC

# Builds PDF book
doc.publishToPDF: 
	source .github/docPublishingScripts.sh && publishPDF

# Builds PDF book
doc.publishToHTML: 
	source .github/docPublishingScripts.sh && publishHTML

# Clean caches
doc.clean:
	rm -rf $(CURDIR)/build
	# docker run --rm -v $(CURDIR):/docs alpine rm -rf /docs/build
