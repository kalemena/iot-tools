int TOGGLE_1_PORT = 3;

void setup(){
  Serial.begin(9600);
  pinMode(TOGGLE_1_PORT, INPUT); 
}

void loop(){
  int toggleState = digitalRead(TOGGLE_1_PORT);

  Serial.println(toggleState);
  delay(250); 
}
