#!/bin/bash

ESP_PORT=${ESP_PORT-/dev/ttyUSB3}
WORKSPACE=${WORKSPACE:-$HOME/workspace}

#UID=${UID:-$(id -u)}
GID=${GID:-$(id -g)}

xhost +local:
docker run -it --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${WORKSPACE}:/home/developer/workspace \
    -e DISPLAY=unix${DISPLAY} \
    --device ${ESP_PORT}:${ESP_PORT} \
    kalemena/arduino:latest arduino
