# Sensors Garden

## Soil Moisture

### Schema #1 - Adafruit

![Adafruit version](res/Arduino-RF-sensor-soil1_bb.png)


### Schema #2 - simple probes (no components)

![Simple probes](res/Arduino-RF-sensor-soil2_bb.png)

Resistor can be 10k pull-up.

### Sketch


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