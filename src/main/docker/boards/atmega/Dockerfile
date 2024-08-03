FROM ubuntu:24.04

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=1.8.19

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Kalemena IoT Tools - Arduino IDE" \
      org.label-schema.description="Kalemena IoT Tools - Arduino IDE" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kalemena/iot-tools" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=$VERSION-atmega \
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

# Arduino CLI
RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

# Setup User (http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)
ENV HOME=/home/developer

# Hide Boards
ADD [ "boards-*.txt", "/tmp/" ]
RUN cat /tmp/boards-atmega.txt >> /usr/local/share/arduino/hardware/arduino/avr/boards.txt

RUN export uid=1000 gid=1000 \
    && mkdir -p ${HOME}/Arduino/libraries \
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

# ADD Libraries
RUN 
WORKDIR ${HOME}/Arduino/libraries

RUN \
# JeeLib    
    wget -q https://github.com/jeelabs/jeelib/archive/master.zip && unzip -q master.zip && rm master.zip \
# LowPowerLab
    && wget -q https://github.com/LowPowerLab/RFM69/archive/master.zip && unzip -q master.zip && rm master.zip \
    && wget -q https://github.com/LowPowerLab/SPIFlash/archive/master.zip && unzip -q master.zip && rm master.zip \
    && wget -q https://github.com/LowPowerLab/LowPower/archive/master.zip && unzip -q master.zip && rm master.zip \
# Adafruit
    && wget -q https://github.com/adafruit/Adafruit_CircuitPlayground/archive/master.zip && unzip -q master.zip && rm master.zip \
    && wget -q https://github.com/adafruit/Adafruit_Sensor/archive/master.zip && unzip -q master.zip && rm master.zip \
    && wget -q https://github.com/adafruit/Adafruit_BusIO/archive/master.zip && unzip -q master.zip && rm master.zip \
# INA219 (current sensor)
    && wget -q https://github.com/adafruit/Adafruit_INA219/archive/refs/tags/1.2.3.zip && unzip -q 1.2.3.zip && rm 1.2.3.zip \
# HTU21
    && wget -q https://github.com/adafruit/Adafruit_HTU21DF_Library/archive/master.zip && unzip -q master.zip && rm master.zip \
# DHT22
    && wget -q https://github.com/adafruit/DHT-sensor-library/archive/master.zip && unzip -q master.zip && rm master.zip \
# BME280
    && wget -q https://github.com/adafruit/Adafruit_BME280_Library/archive/master.zip && unzip -q master.zip && rm master.zip \
# OneWire / DS18B20
    && wget -q https://github.com/PaulStoffregen/OneWire/archive/master.zip && unzip -q master.zip && rm master.zip \
    && wget -q https://github.com/milesburton/Arduino-Temperature-Control-Library/archive/master.zip && unzip -q master.zip && rm master.zip \
# TSL2561
    && wget -q https://github.com/adafruit/TSL2561-Arduino-Library/archive/master.zip && unzip -q master.zip && rm master.zip \
# FastLED
    #&& wget -q https://github.com/kalemena/no-hell-lights/raw/master/libraries/FastLED-3.2.0.zip && unzip -q FastLED-3.2.0.zip && rm FastLED-3.2.0.zip \
    && wget -q https://github.com/FastLED/FastLED/archive/3.7.8.zip && unzip -q 3.7.8.zip && rm 3.7.8.zip \
# WebSocket
    && wget -q https://github.com/Links2004/arduinoWebSockets/archive/master.zip && unzip -q master.zip && rm master.zip \
# JSON
    && wget -q https://github.com/bblanchon/ArduinoJson/archive/refs/tags/v7.2.0.zip && unzip -q v7.2.0.zip && rm v7.2.0.zip && mv ArduinoJson-7.2.0 ArduinoJson \
# Teleinfo
    && wget -q https://github.com/hallard/LibTeleinfo/archive/v1.1.4.zip && unzip -q v1.1.4.zip && rm v1.1.4.zip && mv LibTeleinfo-1.1.4 LibTeleinfo \
# Stepper
    && wget -q http://www.airspayce.com/mikem/arduino/AccelStepper/AccelStepper-1.64.zip && unzip -q AccelStepper-1.64.zip && rm AccelStepper-1.64.zip

WORKDIR ${HOME}

ENV DISPLAY=:1.0
