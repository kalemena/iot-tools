## Teleinfo (French electricity provider)

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