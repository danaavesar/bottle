//Button Press Detection - single message

int buttonPin = 7;
boolean currentState = LOW;//stroage for current button state
boolean lastState = LOW;//storage for last button state
int val;
int numberPressed = 0;
int ledBrightness = 0;
int lightPin = 9;
const int motorPin = 3;
unsigned long timeOfRecording;


void setup(){
  pinMode(buttonPin, INPUT);//this time we will set the pin as INPUT
  Serial.begin(9600);//initialize Serial connection
//  establishContact();
  pinMode(motorPin, OUTPUT);

}

void loop(){

  //button pressing
    currentState = digitalRead(buttonPin);
    if (currentState == HIGH && lastState == LOW){//if button has just been pressed
      Serial.println("pressed");
      numberPressed ++;
       if(numberPressed%2 == 0){
         ledBrightness = ledBrightness + 1;
         timeOfRecording = millis();
           digitalWrite(motorPin, HIGH);
       }
      delay(1);//crude form of button debouncing
    } else if(currentState == LOW && lastState == HIGH){
      Serial.println("released");
      delay(1);//crude form of button debouncing
    }
  lastState = currentState;
  if(millis() > timeOfRecording + 300 ){
      digitalWrite(motorPin, LOW);
  } 

 analogWrite(lightPin ,map(ledBrightness,0, 10, 0, 255));
  
}
