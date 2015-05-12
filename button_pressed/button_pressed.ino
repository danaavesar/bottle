//Button Press Detection - single message

int buttonPin = 7;
boolean currentState = LOW;//stroage for current button state
boolean lastState = LOW;//storage for last button state
int numberOfRecordings;

void setup(){
  pinMode(buttonPin, INPUT);//this time we will set the pin as INPUT
  Serial.begin(9600);//initialize Serial connection

}

void loop(){
  currentState = digitalRead(buttonPin);
  if (currentState == HIGH && lastState == LOW){//if button has just been pressed
    Serial.println("pressed");
    delay(1);//crude form of button debouncing
  } else if(currentState == LOW && lastState == HIGH){
    Serial.println("released");
    delay(1);//crude form of button debouncing
  }
  lastState = currentState;
  
  
}
