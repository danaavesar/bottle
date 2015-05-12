//Button Press Detection - single message

int buttonPin = 7;
boolean currentState = LOW;//stroage for current button state
boolean lastState = LOW;//storage for last button state
int val;
int numberPressed = 0;
int ledBrightness = 0;
int lightPin = 9;

void setup(){
  pinMode(buttonPin, INPUT);//this time we will set the pin as INPUT
  Serial.begin(9600);//initialize Serial connection
//  establishContact();

}

void loop(){
  
  //button pressing


  //if we are receiving something from processing then send processing info
  if (Serial.available() > 0) { // If data is available to read,
    val = Serial.read(); // read it and store it in val

    delay(100);
  } 
  else {
     currentState = digitalRead(buttonPin);
    if (currentState == HIGH && lastState == LOW){//if button has just been pressed
      Serial.println("pressed");
      numberPressed ++;
       if(numberPressed%2 == 0){
         ledBrightness = ledBrightness + 1;
    
       }
      delay(1);//crude form of button debouncing
    } else if(currentState == LOW && lastState == HIGH){
      Serial.println("released");
      delay(1);//crude form of button debouncing
    }
  lastState = currentState;
  }
  

 analogWrite(lightPin ,map(ledBrightness,0, 10, 0, 255));
 Serial.println(ledBrightness);
  
  
}

//void establishContact(){
//  while (Serial.available() <= 0) {
//    Serial.println("A");   // send a capital A
//    delay(300);
//  }
//}
