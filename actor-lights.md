
## Led Strip

### WS2812

WS2812 comes in 5v or 12v.

:bell: 12v are hooked 3 by 3, which means that programmatically there are 3 times less leds.

Each led consumes 0.2W max, to be safe count 20W for 60 led, that is 20W per meter.

I use 5v 150W power supply so that 10m 600 led strip is fine.

##### Wiring

Using Arduino Pro Mini 5v as reference.

As stated in NeoPixel library:

```bash
IMPORTANT: To reduce NeoPixel burnout risk, add 1000 uF capacitor across
pixel power leads, add 300 - 500 Ohm resistor on first pixel's data input
and minimize distance between Arduino and first pixel.  Avoid connecting
on a live circuit...if you must, connect GND first.
```

Then just hook up data pin to one of the pin of arduino.

:bell: for 12v strips, make sure not to burn the arduino 5v: don't hook the Vcc !

##### Sketches

[Test](res/WS2812/WS2812-test/WS2812-test.ino)

##### Resources

* [Adafruit_NeoPixel](https://github.com/adafruit/Adafruit_NeoPixel)