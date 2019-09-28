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

# ADD Libraries
# JeeLib
RUN wget -q https://github.com/jeelabs/jeelib/archive/master.zip -O /tmp/jeelib.zip \
    && mkdir -p ${HOME}/Arduino/libraries \
    && unzip -q /tmp/jeelib.zip -d ${HOME}/Arduino/libraries/ \
    && rm /tmp/jeelib.zip

ENV DISPLAY :1.0
