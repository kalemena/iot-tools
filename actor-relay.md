## Switch

![wiring](res/Arduino-RF-sensor-switch_bb.jpg?raw=true "Wiring Switch")

* 4,7M resistor

```js
int TOGGLE_1_PORT = 7;

void setup(){
  Serial.begin(9600);
  pinMode(TOGGLE_1_PORT, INPUT); 
}

void loop(){
  int toggleState = digitalRead(TOGGLE_1_PORT);

  Serial.println(toggleState);
  delay(250); 
}
```