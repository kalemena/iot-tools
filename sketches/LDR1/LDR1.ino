int LDR_Pin = A0; //analog pin 0

void setup(){
  Serial.begin(9600);
}

void loop()
{
  int32_t LDRReading = analogRead(LDR_Pin); 
  //int32_t LDRReading = 255 - analogRead(LDR_Pin) / 4;

  int32_t LDRfinal = map(LDRReading, 500, 1024, 0, 100);
  Serial.println(LDRfinal);
  delay(250); 
}
