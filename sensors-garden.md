# Sensors Garden

## Soil Moisture

TBD schema
face: A0, D0, GND, VCC

```js
int soil=0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  int sensorValue = analogRead(A0);
  sensorValue = constrain(sensorValue, 600, 1022);
  soil = map(sensorValue, 600, 1022, 100, 0);
  Serial.print(soil);
  Serial.println("%");
  delay(1000);
}
```