FROM ubuntu:18.04

ARG ARDUINO_IDE_VERSION=1.8.10

# Pre-requisits
RUN apt-get update \
	&& apt-get install -y \
        software-properties-common \
        wget unzip \
        openjdk-8-jre \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Arduino IDE
RUN wget -q -O- https://downloads.arduino.cc/arduino-${ARDUINO_IDE_VERSION}-linux64.tar.xz | tar xJC /usr/local/share \
 	&& ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION} /usr/local/share/arduino \
 	&& ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION}/arduino /usr/local/bin/arduino

# Setup User (http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)
ENV HOME /home/developer
WORKDIR ${HOME}

# ADD Libraries
RUN mkdir -p ${HOME}/Arduino/libraries
# JeeLib
RUN wget -q https://github.com/jeelabs/jeelib/archive/master.zip -O /tmp/jeelib.zip && unzip -q /tmp/jeelib.zip -d ${HOME}/Arduino/libraries/ && rm /tmp/jeelib.zip
# LowPowerLab
RUN wget -q https://github.com/LowPowerLab/RFM69/archive/master.zip -O /tmp/rfm69.zip && unzip -q /tmp/rfm69.zip -d ${HOME}/Arduino/libraries/ && rm /tmp/rfm69.zip
RUN wget -q https://github.com/LowPowerLab/SPIFlash/archive/master.zip -O /tmp/spiflash.zip && unzip -q /tmp/spiflash.zip -d ${HOME}/Arduino/libraries/ && rm /tmp/spiflash.zip
RUN wget -q https://github.com/LowPowerLab/LowPower/archive/master.zip -O /tmp/lowpower.zip && unzip -q /tmp/lowpower.zip -d ${HOME}/Arduino/libraries/ && rm /tmp/lowpower.zip
# Adafruit
RUN wget -q https://github.com/adafruit/Adafruit_Sensor/archive/master.zip -O /tmp/sensors.zip && unzip -q /tmp/sensors.zip -d ${HOME}/Arduino/libraries/ && rm /tmp/sensors.zip
# HTU21
RUN wget -q https://github.com/adafruit/Adafruit_HTU21DF_Library/archive/master.zip -O /tmp/htu21d.zip && unzip -q /tmp/htu21d.zip -d ${HOME}/Arduino/libraries/ && rm /tmp/htu21d.zip
# DHT22
RUN wget -q https://github.com/adafruit/DHT-sensor-library/archive/master.zip -O /tmp/dht22.zip && unzip -q /tmp/dht22.zip -d ${HOME}/Arduino/libraries/ && rm /tmp/dht22.zip

RUN export uid=1000 gid=1000 \
    && mkdir -p /home/developer \
    && mkdir -p /etc/sudoers.d \
    && echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd \
    && echo "developer:x:${uid}:" >> /etc/group \
    && echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer \
    && chmod 0440 /etc/sudoers.d/developer \
    && chown ${uid}:${gid} -R /home/developer \
    && sed "s/^dialout.*/&developer/" /etc/group -i \
    && sed "s/^root.*/&developer/" /etc/group -i
USER developer

ENV DISPLAY :1.0
