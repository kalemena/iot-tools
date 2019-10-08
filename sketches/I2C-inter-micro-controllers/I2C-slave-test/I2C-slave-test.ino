

#include <Wire.h>

void receiveEvent(int bytes) {
  int speed = Wire.read();    // read one character from the I2C
  Serial.print("Received=");
  Serial.println(speed);
}

void setup() {
  // Start the I2C Bus as Slave on address 9
  Wire.begin(9); 
  // Attach a function to trigger when something is received.
  Wire.onReceive(receiveEvent);
  delay(1000);
  Serial.begin(9600);
  Serial.println("Hello");
}

void loop() {
  delay(500);
}
