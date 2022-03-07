#!/bin/bash
# PARAMETERS
WORKSPACE=${WORKSPACE:-$HOME/workspace}
DEVICES=${DEVICES:-$1}
VERSION=${VERSION:-1.8.19}

# METHODS
DEVICES_CMD=""
export IFS=";"
for DEVICE in $DEVICES; do
  DEVICES_CMD="${DEVICES_CMD} --device ${DEVICE}:${DEVICE}" 
done

#UID=${UID:-$(id -u)}
#GID=${GID:-$(id -g)}

xhost +local:
docker run -it --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${WORKSPACE}:/home/developer/workspace \
    --device /dev/ttyUSB0:/dev/ttyUSB0 \
    -e DISPLAY=unix${DISPLAY} \
    kalemena/arduino:${VERSION} arduino
