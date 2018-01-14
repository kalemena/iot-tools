# Sensors Light

## LDR

![wiring](res/Arduino-RF-sensor-LDR_bb.png?raw=true "Wiring LDR")

* 60k < resistor < 400k (the higher the less power consumption, but less precise too)
* then callibrate to have an output between 0 and 256

```js
int LDR_Pin = A0; //analog pin 0

void setup(){
  Serial.begin(9600);
}

void loop()
{
  int32_t LDRReading = analogRead(LDR_Pin);

  int32_t LDRfinal = map(LDRReading, 200, 1024, 0, 100);
  Serial.println(LDRfinal);
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




