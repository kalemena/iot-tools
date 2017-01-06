# Sensors Light

## LDR

![wiring](res/Arduino-RF-sensor-LDR_bb.jpg?raw=true "Wiring LDR")

* 60k resistor

```js
int LDR_Pin = A0; //analog pin 0

void setup(){
  Serial.begin(9600);
}

void loop(){
  int LDRReading = analogRead(LDR_Pin); 

  Serial.println(LDRReading);
  delay(250); 
}
```



## TSL2561

This is standard i2c wiring.

For arduino:
- SCL : A5
- SDA : A4

For ESP12!
- SCL : D1
- SDA : D2

[Wiring](https://learn.adafruit.com/tsl2561/wiring)

[Library](https://github.com/adafruit/TSL2561-Arduino-Library)




