#!/bin/bash

IMAGE=${IMAGE:-kalemena/test}
VERSION=${VERSION:-latest}

# PREPARE
docker -v
docker pull ubuntu:20.04
docker pull ${IMAGE}:${VERSION} || true

# BUILD
docker build --pull --cache-from ${IMAGE}:${VERSION} \
    -t ${IMAGE}:${VERSION} \
    -f Dockerfile \
    --build-arg NODERED_VERSION=${VERSION} \
    --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
    --build-arg VCS_REF=`git rev-parse --short HEAD` \
    --build-arg VERSION=${VERSION} .

# CHECK
docker ps -a
docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest
docker images

# # PUSH
# docker login -u "${{ secrets.DOCKER_USERNAME }}" -p "${{ secrets.DOCKER_PASSWORD }}"
# docker push ${IMAGE}:${VERSION}
# docker push ${IMAGE}:latest
# docker logout