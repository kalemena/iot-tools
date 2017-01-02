Few Arduino resources needed for low power sensors building.

Sorry if references are ommited. Resources here come from external sites. 

# RFM12/RFM69CW

Radio module such as RFM12/RFM69CW can be used.

* [Wiring RFM69CW](http://openenergymonitor.org/emon/buildingblocks/rfm12b-wireless)

![wiring](res/ArduinoProMini33-RF-sensor_bb-full.png?raw=true "RFM12 / RFM69CW wiring on 3.3v board")

Once wired, it is possible to verify by uploading JeeLabs RFM12 Demo sketch to have nodes discuss together.

_Important :_ Enable RFM69/12 "compat" mode when using RFM69CW. 

# Sensors

## DS18B20

![wiring](res/ArduinoProMini33-sensor-DS18B20_bb.png?raw=true "Wiring DS18B20")

OneWire and Dallas libraries required to read DS18B20 sensor.

This is possible to wire several sensors together (not explained here).

Sketches to try this in example from libraries to install:
- ![Dallas Temperature](libs/DallasTemperature.zip "Dallas Temperature")
- ![One Wire](libs/OneWire.zip "One Wire")

## DHT22

![wiring](res/ArduinoProMini33-RF-sensor-DHT22_bb.png?raw=true "Wiring DHT22")

_Note :_ For some reasons, the jeelib driver library didn't work using above wiring. 

Sketches to try this in example from libraries to install:
- ![Library DHTxx](libs/arduino-DHT-master.zip "Library DHTxx")

## SHT11

![wiring](res/ArduinoProMini33-RF-sensor-SHT11_bb.png?raw=true "Wiring SHT11")

Usage of Jeelib as driver.

## BMP85

## Soil Moisture

TBD schema
face: A0, D0, GND, VCC

```js
int soil=0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  int sensorValue = analogRead(A0);
  sensorValue = constrain(sensorValue, 600, 1022);
  soil = map(sensorValue, 600, 1022, 100, 0);
  Serial.print(soil);
  Serial.println("%");
  delay(1000);
}
```


## LDR

![wiring](res/Arduino-RF-sensor-LDR_bb.jpg?raw=true "Wiring LDR")

* 60k > 1M resistor

```js
int LDR_Pin = A0; //analog pin 0

void setup(){
  Serial.begin(9600);
}

void loop(){
  int LDRReading = analogRead(LDR_Pin); 

  Serial.println(LDRReading);
  delay(250); 
}
```

## Switch

![wiring](res/Arduino-RF-sensor-switch_bb.jpg?raw=true "Wiring Switch")

* 4,7M resistor

```js
int TOGGLE_1_PORT = 7;

void setup(){
  Serial.begin(9600);
  pinMode(TOGGLE_1_PORT, INPUT); 
}

void loop(){
  int toggleState = digitalRead(TOGGLE_1_PORT);

  Serial.println(toggleState);
  delay(250); 
}
```

## PIR

## pH-meter

## teleinfo (French electricity provider)

[Descriptin & wiring](http://www.planet-libre.org/index.php?post_id=11122)

![wiring](res/ArduinoProMini33-RF-sensor-teleinfo_bb.png?raw=true "Wiring SHT11")

Upload below sketch

```js
#include <SoftwareSerial.h>

SoftwareSerial cptSerial(2, 3);

void setup() {
  Serial.begin(1200);     // opens serial port, sets data rate to 1200 bps
  cptSerial.begin(1200);
}

void loop() {
  if (cptSerial.available())
    Serial.write(cptSerial.read() & 0x7F);
}
```

Once wired to computer, find correct USB tty number (dmesg | grep tty), then execute commands:

```js
$ stty -F /dev/ttyUSB0 1200 sane evenp parenb cs7 -crtscts
$ cat /dev/ttyUSB0
```

Then other library can be used to parse and digest the teleinfo data that looks like below:

```js
ADCO 02092xxxxxx @
OPTARIF HC.. <
ISOUSC 45 ?
HCHC 010956910 %
HCHP 016779643 >
PTEC HP..
IINST 021 Z
IMAX 047 J
PAPP 04860 3
HHPHC A ,
MOTDETAT 000000 B
```

# Low Power

On Deek-Robot board:
* Cut the power led
* !!! Do not cut the regulator !!! On deek-robot board, need to unsolder the regulator Vout instead

[Details here] (http://forum.mysensors.org/topic/230/power-conservation-with-battery-powered-sensors)


# Libraries

Here are unavoidable libraries:
* [Low Power libraries + radio](https://github.com/jcw/jeelib)
* [OneWire](http://www.pjrc.com/teensy/arduino_libraries/OneWire.zip)
* [Dallas](https://github.com/milesburton/Arduino-Temperature-Control-Library)
* [DHT lib](https://github.com/markruys/arduino-DHT)


# Links

* [Deek-Robot pro mini board](http://arduino-board.com/boards/dr-pro-mini)
* [How to Run an Arduino for Years on a Battery](http://www.openhomeautomation.net/arduino-battery/)
* [RFM12 board](http://hallard.me/tag/rfm69cw/)
* [JeeNode Room Board](http://jeelabs.net/projects/hardware/wiki/Room_Board)


# Low-power boards

* Jeenode:
 * [Jeenode pinout](http://jeelabs.net/projects/hardware/wiki/Pinouts)
 * [Specs](http://jeelabs.net/projects/hardware/wiki/JeeNode)
 * [Assembling](http://jeelabs.org/2010/09/26/assembling-the-jeenode-v5/)
 * [SMD kit](http://jeelabs.org/tag/jeesmd/)
 * [SMD kit spec](http://jeelabs.net/projects/hardware/wiki/SMD_Kit)

* [Moteino](http://lowpowerlab.com/moteino/#specs)

* [Tiny328 board] (http://solderpad.com/nathanchantrell/tiny328-wireless-arduino-clone/)

* [Tiny328 specs] (http://nathan.chantrell.net/20130923/tiny328-mini-wireless-arduino-clone/)
