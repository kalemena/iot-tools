#!/bin/bash

IMAGE=${IMAGE:-kalemena/arduino}
VERSION=${VERSION:-1.8.19}

# PREPARE
docker -v
docker pull ${IMAGE}:${VERSION} || true

# INFO
echo IMAGE   = ${IMAGE}
echo VERSION = ${VERSION}

# BUILD
echo "Building ${IMAGE}:${VERSION} ..."

cd src/main/docker
pwd
ls -la

docker build --pull --cache-from ${IMAGE}:${VERSION} \
    -t ${IMAGE}:${VERSION} \
    -f Dockerfile \
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