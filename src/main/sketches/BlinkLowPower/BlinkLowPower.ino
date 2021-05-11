#include <JeeLib.h> // Low power functions library
int led_pin = 13;
ISR(WDT_vect) { Sleepy::watchdogEvent(); } // Setup the watchdog
 
void setup() {
  pinMode(led_pin, OUTPUT);
  Serial.begin(9600);
}
 
void loop() {
  // Turn the LED on and sleep for 5 seconds
  //digitalWrite(led_pin, HIGH);
  
  //Sleepy::loseSomeTime(5000);
  delay(5000);
 
  analogRead(0);
  word sensorValue = analogRead(0);
  Serial.println(sensorValue);
    
  /*
  // Turn the LED off and sleep for 15 seconds
  //digitalWrite(led_pin, LOW);
  //Sleepy::loseSomeTime(5000);
  //delay(5);
  for (byte i = 0; i < 4; ++i) {
    analogRead(A0);
    int sensorValue = analogRead(A0);
    Serial.println(sensorValue);
  }*/
}
