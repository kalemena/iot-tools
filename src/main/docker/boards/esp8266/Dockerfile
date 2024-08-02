ARG VERSION=1.8.19
FROM kalemena/arduino:${VERSION}-atmega-latest

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Kalemena IoT Tools - Arduino IDE for ESP8266" \
      org.label-schema.description="Kalemena IoT Tools - Arduino IDE for ESP8266" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kalemena/iot-tools" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=${VERSION}-esp8266 \
      org.label-schema.schema-version="1.0"

ENV DEBIAN_FRONTEND=noninteractive

USER root

# Flash Tools
RUN pip3 --no-cache-dir install esptool --break-system-packages \
    && ln -s /usr/bin/python3 /usr/bin/python

USER developer

# Boards
# ESP8266
# RUN mkdir -p /usr/local/share/arduino/hardware/esp8266com \
#     && cd /usr/local/share/arduino/hardware/esp8266com \
#     && wget -q https://github.com/esp8266/Arduino/releases/download/3.0.2/esp8266-3.0.2.zip && unzip -q esp8266-3.0.2.zip && rm esp8266-3.0.2.zip \
#     && mv esp8266-3.0.2 esp8266 \   
#     && cd esp8266/tools \
#     && python3 get.py

RUN mkdir -p /usr/local/share/arduino/hardware/esp8266com \
    && cd /usr/local/share/arduino/hardware/esp8266com \
    && git clone https://github.com/esp8266/Arduino.git esp8266 \
    && cd esp8266 \
    && git submodule update --init \
    && cd tools \
    && python3 get.py \
# cleanup
    && find /usr/local/share/arduino/hardware/esp8266com \( -name ".git" -o -name ".gitignore" -o -name ".gitmodules" -o -name ".gitattributes" \) -exec rm -rf -- {} +

# ESP8266 FS
RUN mkdir -p ${HOME}/Arduino/tools \
    && cd ${HOME}/Arduino/tools \
    && wget -q https://github.com/esp8266/arduino-esp8266fs-plugin/releases/download/0.5.0/ESP8266FS-0.5.0.zip && unzip -q ESP8266FS-0.5.0.zip && rm ESP8266FS-0.5.0.zip
# ESP8266 Little FS
RUN mkdir -p ${HOME}/Arduino/tools \
    && cd ${HOME}/Arduino/tools \
    && wget -q https://github.com/earlephilhower/arduino-esp8266littlefs-plugin/releases/download/2.6.0/ESP8266LittleFS-2.6.0.zip && unzip -q ESP8266LittleFS-2.6.0.zip && rm ESP8266LittleFS-2.6.0.zip

# Hide Boards
ADD [ "boards-*.txt", "/tmp/" ]
RUN cat /tmp/boards-esp8266.txt >> /usr/local/share/arduino/hardware/esp8266com/esp8266/boards.txt

WORKDIR ${HOME}