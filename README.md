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

## DHT22

![wiring](res/DHT22.png?raw=true "Wiring DHT22")

_Note :_ For some reasons, the jeelib driver library didn't work using above wiring. 

Arduino-DHT lib needs to be used.

## SHT11

## BMP85

## Soil Moisture

http://to302.phps.kr/wordpress/?p=177

## LDR

## PIR

## pH-meter

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