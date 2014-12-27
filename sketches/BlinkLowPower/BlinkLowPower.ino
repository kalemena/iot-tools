#include <JeeLib.h> // Low power functions library
int led_pin = 13;
ISR(WDT_vect) { Sleepy::watchdogEvent(); } // Setup the watchdog
 
void setup() {
  pinMode(led_pin, OUTPUT);
}
 
void loop() {
  // Turn the LED on and sleep for 5 seconds
  digitalWrite(led_pin, HIGH);
  Sleepy::loseSomeTime(5000);
  
  // Turn the LED off and sleep for 5 seconds
  digitalWrite(led_pin, LOW);
  Sleepy::loseSomeTime(5000);
}
