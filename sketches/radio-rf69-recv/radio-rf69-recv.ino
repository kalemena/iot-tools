/**************************************************************************************/
/* Simple sketch to check RFM69 is correctly connected to the Arduino.                */
/*        Part of the Global Home Automation System GHAS.                             */
/*                                                                                    */
/*                                                                                    */
/* Version: 0.0.1                                                                     */
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
#define NODEID      50
#define NETWORKID   5
#define FREQUENCY   RF69_868MHZ
#define ENCRYPTKEY  "1234567890123456"  //Encrypt key must be 16 characters
#define IS_RFM69HW

//Setup the watchdog
ISR(WDT_vect) {Sleepy::watchdogEvent();}

//Declare RFM69 driver
RFM69 radio;

//Data table
typedef struct
  {
  float    rfmTemp;      //Temperature (°C)
  float    humidity;     //Humidity (%)
  float    voltage;      //Voltage of battery capacity (v)
  byte     measure;      //Measure number (from 0 to 250, +1 each new measurement)
  } Payload;
Payload dataReceived;

//Misc.
const char VERSION[] = "GHAS RFM69 test (receiver) v0.0.1";

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

  //Initialize RFM69 driver
  radio.initialize(FREQUENCY, NODEID, NETWORKID);
  radio.setHighPower();
  radio.encrypt(ENCRYPTKEY);
  radio.promiscuous(true);

  #ifdef DEBUG
    char buff[50];
    sprintf(buff, "Listening at %d Mhz...\n", FREQUENCY==RF69_433MHZ ? 433 : FREQUENCY==RF69_868MHZ ? 868 : 915);
    Serial.println(buff);
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
  //Check if data have been received
  if (radio.receiveDone())
    {
    int dataValid = 0;
    if (radio.DATALEN != sizeof(dataReceived))
      {
      dataValid = 0;
      #ifdef DEBUG
        Serial.print("Invalid payload received, not matching Payload struct!");
      #endif
      }
    else
      {
      dataValid = 1;
      dataReceived = *(Payload*)radio.DATA;
      }

    //Send an ACK if required by the node
    if (radio.ACKRequested())
      {
      //radio.SENDERID = NODEID;
      radio.sendACK();
      #ifdef DEBUG
        Serial.print("[ACK-sent]");
      #endif
      }
  
    //Display information on serial line if required
    #ifdef DEBUG
      Serial.print("[RSSI:");
      Serial.print(radio.RSSI, DEC);
      Serial.print("]");
      Serial.print("[TEMP:");
      Serial.print(dataReceived.rfmTemp, DEC);
      Serial.print("]");
      Serial.print("[VOLTAGE:");
      Serial.print(dataReceived.voltage);
      Serial.print(" v]");
      Serial.print("[MEASURE:");
      Serial.print(dataReceived.measure);
      Serial.print("] ");
      Serial.println();
    #endif
    }
  }
