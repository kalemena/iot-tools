/**************************************************************************************/
/* Simple sketch to check RFM69 is correctly connected to the Arduino.                */
/*        Part of the Global Home Automation System GHAS.                             */
/*                                                                                    */
/*                                                                                    */
/* Version: 0.0.5                                                                     */
/* Date   : 28/12/2015                                                                */
/* Author : David Carlier                                                             */
/**************************************************************************************/
/*                                ---------------                                     */
/*                            RST |             |  A5                                 */
/*                            RX  |             |  A4                                 */
/*                            TX  |   ARDUINO   |  A3                                 */
/*     RFM69 (DIO0) --------- D2  |     UNO     |  A2                                 */
/*                            D3  |             |  A1                                 */
/*                            D4  | ATMEGA 328p |  A0                                 */
/*            +3.3v --------- VCC |             | GND --------- GND                   */
/*              GND --------- GND |  8MHz int.  | REF                                 */
/*                            OSC |             | VCC --------- +3.3v                 */
/*                            OSC |             | D13 --------- RFM69 (SCK)           */
/*                            D5  |             | D12 --------- RFM69 (MISO)          */
/*                            D6  |             | D11 --------- RFM69 (MOSI)          */
/*                            D7  |             | D10 --------- RFM69 (NSS)           */
/*                            D8  |             |  D9                                 */
/*                                ---------------                                     */
/*                                                                                    */
/*                                                                                    */
/**************************************************************************************/
/*                                                                                    */
/* Used library:                                                                      */
/*                                                                                    */
/*     RFM69  : https://github.com/LowPowerLab/RFM69                                  */
/*     Jeelib : http://jeelabs.net/projects/jeelib/wiki                               */
/*                                                                                    */
/**************************************************************************************/

//Include low power library
#include <JeeLib.h>

//Include RFM69 library
#include <RFM69.h>
#include <SPI.h>

//Active mode debug.
#define DEBUG

//Define RFM69 settings
#define GATEWAYID   50
#define NODEID      35
#define NETWORKID   5
#define FREQUENCY   RF69_868MHZ
#define ENCRYPTKEY  "1234567890123456"  //Encrypt key must be 16 characters
// #define IS_RFM69HW

//Setup the watchdog
ISR(WDT_vect) {Sleepy::watchdogEvent();}

//Declare RFM69 driver
RFM69 radio;

//Declare local constants
#define LOOP_DELAY   1000

//Data table
typedef struct
  {
  float    rfmTemp;      //Temperature (°C)
  float    humidity;     //Humidity (%)
  float    voltage;      //Voltage of battery capacity (v)
  byte     measure;      //Measure number (from 0 to 250, +1 each new measurement)
  } Payload;
Payload dataToSend;

//Misc.
const char VERSION[] = "GHAS RFM69 test (transmitter) v0.0.5";

/**************************************************************************************/
/* Initialization                                                                     */
/**************************************************************************************/
void setup()
  {
  //Open a serial connection to display values
  #ifdef DEBUG
    Serial.begin(115200);
    Serial.print("Starting ");
    Serial.println(VERSION);
  #endif

  //Initialize data
  dataToSend.measure = 0;

  //Initialize RFM69 driver
  radio.initialize(FREQUENCY, NODEID, NETWORKID);
  radio.setHighPower();
  radio.encrypt(ENCRYPTKEY);

  #ifdef DEBUG
    radio.readAllRegs();
    Serial.flush();
  #endif

  delay(1000);
  }

/**************************************************************************************/
/* Main loop                                                                          */
/**************************************************************************************/
void loop()
  {
  //Get informations
  dataToSend.voltage = getVoltage() / 100.0;
  dataToSend.rfmTemp = radio.readTemperature(0);

  //Insert number of measure
  dataToSend.measure++;
  if (dataToSend.measure > 250) {dataToSend.measure = 0;}

  //Send data on serial link
  #ifdef DEBUG
    Serial.print(dataToSend.rfmTemp, 1);
    Serial.print(" degC");
    Serial.print("   ");
    Serial.print(dataToSend.voltage);
    Serial.print(" v");
    Serial.print("   (");
    Serial.print(dataToSend.measure);
    Serial.println(")");
    Serial.flush();
  #endif

  //Send data
  if (radio.sendWithRetry(GATEWAYID, (const void*)(&dataToSend), sizeof(dataToSend)))
    {
    #ifdef DEBUG
      Serial.println("Transmission done without problem !");
      Serial.flush();
    #endif
    }
  else
    {
    #ifdef DEBUG
      Serial.println("Error with transmission !");
      Serial.flush();
    #endif
    }
  
  //Waiting time before next measurement (minimum 3 seconds)
  radio.sleep();
  //delay(LOOP_DELAY);
  Sleepy::loseSomeTime(LOOP_DELAY);
  }

/**************************************************************************************/
/* Allows to get the real Vcc (return value * 100).                                   */
/**************************************************************************************/
int getVoltage()
  {
  const long InternalReferenceVoltage = 1056L;
  ADMUX = (0<<REFS1) | (1<<REFS0) | (0<<ADLAR) | (1<<MUX3) | (1<<MUX2) | (1<<MUX1) | (0<<MUX0);
  delay(50);  // Let mux settle a little to get a more stable A/D conversion
  //Start a conversion  
  ADCSRA |= _BV( ADSC );
  //Wait for it to complete
  while (((ADCSRA & (1<<ADSC)) != 0));
  //Scale the value
  int result = (((InternalReferenceVoltage * 1023L) / ADC) + 5L) / 10L;
  return result;
  }
