#!/bin/bash
# PARAMETERS
WORKSPACE=${WORKSPACE:-$HOME/workspace}
BOARD=${BOARD:-$1}
DEVICE=${DEVICE:-$2}
VERSION=${VERSION:-1.8.19}
MACHINE_TYPE=$(uname -s)

# macOS (Docker Desktop) needs different X11 handling
if [ "$MACHINE_TYPE" = "Darwin" ]; then
    IP=$(ipconfig getifaddr en0 2>/dev/null || echo "host.docker.internal")
    xhost + "${IP}" >/dev/null 2>&1
    xhost + 127.0.0.1 >/dev/null 2>&1
    DISPLAY_VAR="${IP}:0"
    X11_MOUNT=""
else
    xhost +local: >/dev/null 2>&1
    DISPLAY_VAR="unix${DISPLAY}"
    X11_MOUNT="-v /tmp/.X11-unix:/tmp/.X11-unix"
fi

docker run ${DOCKER_PLATFORM} -it --rm \
    ${X11_MOUNT} \
    -v ${WORKSPACE}:/home/developer/workspace \
    --privileged -v ${DEVICE}:${DEVICE} \
    -e DISPLAY=${DISPLAY_VAR} \
    kalemena/arduino:${VERSION}-${BOARD}-latest arduino
