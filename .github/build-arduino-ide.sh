#!/bin/bash

IMAGE=${IMAGE:-kalemena/arduino}
VERSION=${VERSION:-1.8.19}
BOARD=${BOARD:-arduino}

# PREPARE
docker -v
docker pull ${IMAGE}:${VERSION}-${BOARD} || true

# INFO
echo IMAGE   = ${IMAGE}
echo VERSION = ${VERSION}
echo BOARD = ${BOARD}

# BUILD
echo "Building ${IMAGE}:${VERSION}-${BOARD} ..."

cd src/main/docker/boards/${BOARD}
pwd
ls -la

docker build --pull --cache-from ${IMAGE}:${VERSION}-${BOARD} \
    -t ${IMAGE}:${VERSION}-${BOARD} \
    -f Dockerfile \
    --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
    --build-arg VCS_REF=`git rev-parse --short HEAD` \
    --build-arg VERSION=${VERSION}-${BOARD} .

# CHECK
docker ps -a
docker tag ${IMAGE}:${VERSION}-${BOARD} ${IMAGE}:latest
docker images

# # PUSH
# docker login -u "${{ secrets.DOCKER_USERNAME }}" -p "${{ secrets.DOCKER_PASSWORD }}"
# docker push ${IMAGE}:${VERSION}
# docker push ${IMAGE}:latest
# docker logout