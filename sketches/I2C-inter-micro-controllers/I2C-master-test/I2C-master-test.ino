#include <Wire.h>

void sendAction(int speed) {
    Serial.print("Sending=");
    Serial.println(randNumber);
    Wire.beginTransmission(9);  // transmit to device #9
    Wire.write(speed);          // sends speed
    Wire.endTransmission();     // stop transmitting
}

void setup() {
  Serial.begin(9600);//baud rate at which arduino communicates with Laptop/PC
  Wire.begin(); 

  randomSeed(analogRead(0));
  
  delay(2000);//delay for 2 sec
}

void loop() //method to run the source code repeatedly
{
  delay(2000);

  int randNumber = random(10, 20);
  sendAction(randNumber);
}
