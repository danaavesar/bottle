const int transistorPin = A0; 


 void setup() {
   pinMode(transistorPin, OUTPUT);
 }

 void loop() {

     analogWrite(transistorPin, 255);
    
   for (int brightness = 0; brightness < 255; brightness++) {
      analogWrite(transistorPin, brightness);
      delay(10);
    }

    delay(2000);

    for (int brightness = 255; brightness >= 0; brightness--) {
          analogWrite(transistorPin, brightness);
          
          delay(10);
    }

    delay(2000);
 }

