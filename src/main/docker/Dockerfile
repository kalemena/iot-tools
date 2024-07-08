FROM ubuntu:22.04

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=1.8.19
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Kalemena Arduino Tools" \
      org.label-schema.description="Kalemena Arduino Tools" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kalemena/iot-tools" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

ENV DEBIAN_FRONTEND=noninteractive

# Pre-requisits
RUN apt-get -y update \
	&& apt-get -y install \
        software-properties-common \
        wget unzip \
        openjdk-11-jre \
        python3 python3-pip \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Arduino IDE
RUN wget -q -O- https://downloads.arduino.cc/arduino-${VERSION}-linux64.tar.xz | tar xJC /usr/local/share \
 	&& ln -s /usr/local/share/arduino-${VERSION} /usr/local/share/arduino \
 	&& ln -s /usr/local/share/arduino-${VERSION}/arduino /usr/local/bin/arduino

# Setup User (http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)
ENV HOME=/home/developer

# Flash Tools
RUN pip3 --no-cache-dir install esptool \
    && ln -s /usr/bin/python3 /usr/bin/python

# Boards
# ESP8266
# RUN mkdir -p /usr/local/share/arduino/hardware/esp8266com \
#     && cd /usr/local/share/arduino/hardware/esp8266com \
#     && wget -q https://github.com/esp8266/Arduino/releases/download/2.7.4/esp8266-2.7.4.zip && unzip -q esp8266-2.7.4.zip && rm esp8266-2.7.4.zip \
#     && mv esp8266-2.7.4 esp8266 \   
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
ADD [ "boards/boards-*.txt", "/tmp/" ]
RUN cat /tmp/boards-arduino.txt >> /usr/local/share/arduino/hardware/arduino/avr/boards.txt \
    && cat /tmp/boards-esp8266.txt >> /usr/local/share/arduino/hardware/esp8266com/esp8266/boards.txt \
    && cat /tmp/boards-esp32.txt >> /usr/local/share/arduino/hardware/esp32com/esp32/boards.txt

# ADD Libraries
RUN mkdir -p ${HOME}/Arduino/libraries
WORKDIR ${HOME}/Arduino/libraries
# JeeLib
RUN wget -q https://github.com/jeelabs/jeelib/archive/master.zip && unzip -q master.zip && rm master.zip
# LowPowerLab
RUN wget -q https://github.com/LowPowerLab/RFM69/archive/master.zip && unzip -q master.zip && rm master.zip
RUN wget -q https://github.com/LowPowerLab/SPIFlash/archive/master.zip && unzip -q master.zip && rm master.zip
RUN wget -q https://github.com/LowPowerLab/LowPower/archive/master.zip && unzip -q master.zip && rm master.zip
# Adafruit
RUN wget -q https://github.com/adafruit/Adafruit_Sensor/archive/master.zip && unzip -q master.zip && rm master.zip
RUN wget -q https://github.com/adafruit/Adafruit_BusIO/archive/master.zip && unzip -q master.zip && rm master.zip
# INA219 (current sensor)
RUN wget -q https://github.com/adafruit/Adafruit_INA219/archive/refs/tags/1.2.0.zip && unzip -q 1.2.0.zip && rm 1.2.0.zip
# HTU21
RUN wget -q https://github.com/adafruit/Adafruit_HTU21DF_Library/archive/master.zip && unzip -q master.zip && rm master.zip
# DHT22
RUN wget -q https://github.com/adafruit/DHT-sensor-library/archive/master.zip && unzip -q master.zip && rm master.zip
# BME280
RUN wget -q https://github.com/adafruit/Adafruit_BME280_Library/archive/master.zip && unzip -q master.zip && rm master.zip
# OneWire / DS18B20
RUN wget -q https://github.com/PaulStoffregen/OneWire/archive/master.zip && unzip -q master.zip && rm master.zip
RUN wget -q https://github.com/milesburton/Arduino-Temperature-Control-Library/archive/master.zip && unzip -q master.zip && rm master.zip
# TSL2561
RUN wget -q https://github.com/adafruit/TSL2561-Arduino-Library/archive/master.zip && unzip -q master.zip && rm master.zip
# FastLED
#RUN wget -q https://github.com/kalemena/no-hell-lights/raw/master/libraries/FastLED-3.2.0.zip && unzip -q FastLED-3.2.0.zip && rm FastLED-3.2.0.zip
RUN wget -q https://github.com/FastLED/FastLED/archive/3.4.0.zip && unzip -q 3.4.0.zip && rm 3.4.0.zip
# WebSocket
RUN wget -q https://github.com/Links2004/arduinoWebSockets/archive/master.zip && unzip -q master.zip && rm master.zip
# JSON
RUN wget -q https://github.com/bblanchon/ArduinoJson/releases/download/v6.19.3/ArduinoJson-v6.19.3.zip && unzip -q ArduinoJson-v6.19.3.zip && rm ArduinoJson-v6.19.3.zip
# Teleinfo
RUN wget -q https://github.com/hallard/LibTeleinfo/archive/v1.1.4.zip && unzip -q v1.1.4.zip && rm v1.1.4.zip && mv LibTeleinfo-1.1.4 LibTeleinfo
# Stepper
RUN wget -q http://www.airspayce.com/mikem/arduino/AccelStepper/AccelStepper-1.64.zip && unzip -q AccelStepper-1.64.zip && rm AccelStepper-1.64.zip

WORKDIR ${HOME}

RUN export uid=1000 gid=1000 \
    && mkdir -p /home/developer \
    && mkdir -p /etc/sudoers.d \
    && echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd \
    && echo "developer:x:${uid}:" >> /etc/group \
    && echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer \
    && chmod 0440 /etc/sudoers.d/developer \
    && chown ${uid}:${gid} -R /home/developer \
    && chown ${uid}:${gid} -R /usr/local/share/arduino \
    && sed "s/^dialout.*/&developer/" /etc/group -i \
    && sed "s/^root.*/&developer/" /etc/group -i
USER developer

ENV DISPLAY=:1.0
