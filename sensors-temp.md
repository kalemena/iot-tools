# Sensors Temperature

[Interesting compare of sensors](https://blog.openenergymonitor.org/2016/07/HTU21D-Temperature-Humidity-sensor/)


## DS18B20

Temperature sensor.

Resources:
* [OneWire](http://www.pjrc.com/teensy/arduino_libraries/OneWire.zip)
* [Dallas](https://github.com/milesburton/Arduino-Temperature-Control-Library)

![wiring](res/ArduinoProMini33-sensor-DS18B20_bb.png?raw=true "Wiring DS18B20")

OneWire and Dallas libraries required to read DS18B20 sensor.

This is possible to wire several sensors together (not explained here).

Sketches to try this in example from libraries to install:
- ![Dallas Temperature](libs/DallasTemperature.zip "Dallas Temperature")
- ![One Wire](libs/OneWire.zip "One Wire")


## DHT22

Temperature and humidity sensor.

Resources:
* [DHT lib](https://github.com/markruys/arduino-DHT)

![wiring](res/ArduinoProMini33-RF-sensor-DHT22_bb.png?raw=true "Wiring DHT22")

_Note :_ For some reasons, the jeelib driver library didn't work using above wiring. 

Sketches to try this in example from libraries to install:
- ![Library DHTxx](libs/arduino-DHT-master.zip "Library DHTxx")


## SHT11

Temperature and humidity sensor.

![wiring](res/ArduinoProMini33-RF-sensor-SHT11_bb.png?raw=true "Wiring SHT11")

Usage of Jeelib as driver.


## BMP85

Temperature and pressure sensor.

:bell: TODO


## HTU21D

Temperature and humidity sensor.

This is standard i2c wiring.

For arduino:
- SCL : A5
- SDA : A4

For ESP12!
- SCL : D1
- SDA : D2

[HTU21D Pinouts](https://learn.adafruit.com/adafruit-htu21d-f-temperature-humidity-sensor/wiring-and-test)

