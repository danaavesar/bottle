String c;
void setup() {
  //start serial connection
  Serial.begin(9600);
  //configure pin2 as an input and enable the internal pull-up resistor
  pinMode(2, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  

}

void loop() {
  //read the pushbutton value into a variable
  int sensorVal = digitalRead(2);
  int sensorVal2 = digitalRead(4);
  //print out the value of the pushbutton
  c = ",";
  Serial.println(sensorVal2 + c + sensorVal);
//     Serial.print("\t");
//  Serial.println(sensorVal2);
      
  
}
