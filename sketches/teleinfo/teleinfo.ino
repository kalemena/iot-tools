#include <SoftwareSerial.h>

SoftwareSerial teleinfo(14, 15);  // ESP32
//SoftwareSerial teleinfo(2,3);   // Arduino 

void setup() {
  Serial.begin(1200);     // opens serial port, sets data rate to 1200 bps
  teleinfo.begin(1200);

  Serial.println("Teleinfo module is up...");
}

int i = 0;
void loop() {
  if (teleinfo.available())
    Serial.write(teleinfo.read() & 0x7F);
  if(++i % 100000 == 0)
    Serial.println(".");
}


