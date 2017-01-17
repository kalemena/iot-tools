/*
http://www.domotique-info.fr/2014/05/recuperer-teleinformation-arduino/
 
Usage :
  + This is a simple Teleinfo Test program
  + It's just to test the TeleInfo board and its 
    connexion to the EDF counter
  + It just displays the received teleInfo data on
    the Serial Monitor
  + No Internet connexion, no data transfered

Hardware needed :
  + 1 x Arduino UNO r3
  + 1 x Opto Coupler : SFH620A
  + 1 x LED
  + 1 x 1 k? resistor
  + 1 x 4,7 k? resistor

PIN USED :
  PIN 8  : Software Serial RX
  PIN 9  : Software Serial TX
*/

#include <SoftwareSerial.h>

#define startFrame 0x02
#define endFrame 0x03

SoftwareSerial* cptSerial;

void setup()
{
  Serial.begin(115200);
  cptSerial = new SoftwareSerial(8, 9);
  cptSerial->begin(1200);
  Serial.println(F("setup complete"));
}

void loop()
{
  char charIn = 0;
  
  while (charIn != startFrame)
  {
    // Teleinfo uses 7 bites, removing last 8th bit
    charIn = cptSerial->read() & 0x7F;
  }
  
  while (charIn != endFrame)
  {
    if (cptSerial->available())
    {
      // Teleinfo uses 7 bites, removing last 8th bit
      charIn = cptSerial->read() & 0x7F;      
      Serial.print(charIn);
    }
  }
  
  Serial.println("");
}
