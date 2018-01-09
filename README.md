Few Arduino resources needed for low power sensors building.

Sorry if references are ommited.
Resources come from external sites, sometimes with more details. 

* [Radio RFM12](radio.md)
* [Sensors Temperature](sensors-temp.md)
* [Sensors Light](sensors-light.md)
* [Sensors gardening](sensors-garden.md)
* [Sensors switch](sensors-switch.md)
* [Actor light strips](actor-lights.md)
* [Interop Teleinfo](interop-teleinfo.md)

# Radio

* [RFM12 board](http://hallard.me/tag/rfm69cw/)
* [Low Power libraries + radio](https://github.com/jcw/jeelib)

# Low-power

## Info

On Deek-Robot board:
* Cut the power led
* !!! Do not cut the regulator !!! On deek-robot board, need to unsolder the regulator Vout instead

Links:
* [Details here](http://forum.mysensors.org/topic/230/power-conservation-with-battery-powered-sensors)
* [How to Run an Arduino for Years on a Battery](http://www.openhomeautomation.net/arduino-battery/)

## Measures

Below are measures for:
- cheap e-Bay arduino 3.3v clone (deek-robot)
- radio RFM69 wired
- using Jeelab libs. Enhanced sleep.
- various sensors

| What? | Measure | Diff | Comments |
| ----- | ----- | ----- | ----- |
| Arduino + RFM69 | 5.1 uA | NA | Deek Robot with cuting led and regulator |
| + DHT22 | 17.2 uA | +12uA | |
| + HTU21D | 12.8 uA | +8uA | |
| + DS12B20 | 21.9 uA | +17uA | |
| + LDR | 26 uA | +21uA | Using 200k as pull-down |
| + TSL2561 | 17.4 uA | +12uA | |
| + Soil | 5.2 uA | +0.1uA | Soil 2 - simple probes with 10k resistor pull-up |
| + Toggle | 5.2 uA | +0.1uA | Toggle with 10M pull-up resistor! |

# Boards links

* Jeenode:
  * [Jeenode pinout](http://jeelabs.net/projects/hardware/wiki/Pinouts)
  * [Specs](http://jeelabs.net/projects/hardware/wiki/JeeNode)
  * [Assembling](http://jeelabs.org/2010/09/26/assembling-the-jeenode-v5/)
  * [SMD kit](http://jeelabs.org/tag/jeesmd/)
  * [SMD kit spec](http://jeelabs.net/projects/hardware/wiki/SMD_Kit)
  * [JeeNode Room Board](http://jeelabs.net/projects/hardware/wiki/Room_Board)
* [Deek-Robot pro mini board](http://arduino-board.com/boards/dr-pro-mini)
* [Moteino](http://lowpowerlab.com/moteino/#specs)
* [Tiny328 board](http://solderpad.com/nathanchantrell/tiny328-wireless-arduino-clone/)
* [Tiny328 specs](http://nathan.chantrell.net/20130923/tiny328-mini-wireless-arduino-clone/)
* [RFM95 sensors](https://things4u.github.io/HardwareGuide/Arduino/Mini-Sensor-HTU21/mini-lowpower.html)