#!/bin/bash
# PARAMETERS
WORKSPACE=${WORKSPACE:-$HOME/workspace}
BOARD=${BOARD:-$1}
DEVICE=${DEVICE:-$2}
VERSION=${VERSION:-1.8.19}

xhost +local:
docker run -it --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${WORKSPACE}:/home/developer/workspace \
    --device ${DEVICE}:${DEVICE} \
    -e DISPLAY=unix${DISPLAY} \
    kalemena/arduino:${VERSION}-${BOARD}-latest arduino
