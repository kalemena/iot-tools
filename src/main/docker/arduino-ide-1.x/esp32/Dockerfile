ARG VERSION=1.8.19
FROM kalemena/arduino:${VERSION}-atmega-latest

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Kalemena IoT Tools - Arduino IDE for ESP32" \
      org.label-schema.description="Kalemena IoT Tools - Arduino IDE for ESP32" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kalemena/iot-tools" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=${VERSION}-esp32 \
      org.label-schema.schema-version="1.0"

ENV DEBIAN_FRONTEND=noninteractive

USER root

# Flash Tools
RUN pip3 --no-cache-dir install esptool --break-system-packages \
    && ln -s /usr/bin/python3 /usr/bin/python

USER developer

# ESP32
RUN mkdir -p /usr/local/share/arduino/hardware/esp32com \
    && cd /usr/local/share/arduino/hardware/esp32com \
    && wget -q https://github.com/espressif/arduino-esp32/archive/master.zip && unzip -q master.zip && rm master.zip \
    && mv arduino-esp32-master esp32 \
    && cd esp32/tools \
    && python3 get.py
# ESP32 FS
RUN mkdir -p ${HOME}/Arduino/tools \
    && cd ${HOME}/Arduino/tools \
    && wget -q https://github.com/me-no-dev/arduino-esp32fs-plugin/releases/download/1.1/ESP32FS-1.1.zip && unzip -q ESP32FS-1.1.zip && rm ESP32FS-1.1.zip
    
# Hide Boards
ADD [ "boards-*.txt", "/tmp/" ]
RUN cat /tmp/boards-esp32.txt >> /usr/local/share/arduino/hardware/esp32com/esp32/boards.txt

WORKDIR ${HOME}