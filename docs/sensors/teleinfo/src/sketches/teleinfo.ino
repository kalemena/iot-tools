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