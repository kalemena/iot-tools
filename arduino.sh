#!/bin/bash
# PARAMETERS
WORKSPACE=${WORKSPACE:-$HOME/workspace}
DEVICES=${DEVICES:-$1}

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
    --device /dev/ttyUSB2:/dev/ttyUSB2 \
    -e DISPLAY=unix${DISPLAY} \
    kalemena/arduino:1.8.13 arduino
