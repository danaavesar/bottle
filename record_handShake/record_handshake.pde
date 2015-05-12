//arduino button connected to pin7, toggled

import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.spi.*;
import processing.serial.*;

Serial myPort;
Minim minim;
String val;

boolean firstContact = false;
int linefeed = 10;
// for recording
AudioInput in;
AudioRecorder [] recorders;

// for playing back
AudioOutput out;
FilePlayer player;


int numberOfRecordings = -1;

String recordingStatus = "";
Boolean keytoggle = false;

String stats[]  = {"record", "play"};
int currentPlaybackIndex = 0;

void setup(){
  size(512, 200, P3D);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048);
  recorders = new AudioRecorder[50];
  for(int i=0; i< 50; i++){
    recorders[i] = minim.createRecorder(in, "data/" + str(i) + ".wav");
  }
  out = minim.getLineOut( Minim.STEREO );
  textFont(createFont("Arial", 12));  
  String portName = Serial.list()[5]; 
  //println(Serial.list()[3]);
  myPort = new Serial(this, portName, 9600); 
  myPort.bufferUntil(linefeed);
}

//get serial reading
void serialEvent(Serial myPort){
  val = myPort.readStringUntil('\n');
  
  if(val != null){
    val = trim(val);
    println(val);
    
    //if (firstContact == false) {
      if (val.equals("A")) {
        myPort.clear();
        firstContact = true;
        myPort.write("A");
        println("contact");
      }
    //}else{
      println(val);
      //if we read pressed
      if (val.equals("pressed")){
        keytoggle = true;
      } else{
        keytoggle = false;
      }   
      if (!keytoggle) {
        if (recordingStatus == "" ){
          int tempId = numberOfRecordings + 1;
          numberOfRecordings = tempId % 50;
          recorders[numberOfRecordings].beginRecord();
          recordingStatus = "record";
         } else if (recordingStatus == "record") {
            currentPlaybackIndex = -1;
            recorders[numberOfRecordings].endRecord();
            recorders[numberOfRecordings].save();
            myPort.write(1);
            println(1);
            recordingStatus = "play";
         } else if (recordingStatus == "play") {
            player.pause();
      
            int tempId = numberOfRecordings + 1;
            numberOfRecordings = tempId % 50;
            recorders[numberOfRecordings].beginRecord();
      
            recordingStatus = "record";
       }//close of if !keytoggle
       println("keyPressed : " + recordingStatus + " : " + numberOfRecordings);
     }
    keytoggle = true; 
   //myPort.write("A");
//  } //close of else for if not first contact
 }//close of if val != null


}



void draw(){

  
  background(0); 
  stroke(255);

  if (player != null ) {
    if (!player.isPlaying() && recordingStatus == "play") {
      currentPlaybackIndex +=  1;
      currentPlaybackIndex = (currentPlaybackIndex > numberOfRecordings) ? 0 : currentPlaybackIndex;
      String fileName = "data/" + currentPlaybackIndex + ".wav";
      AudioRecordingStream myFile = minim.loadFileStream( fileName, 1024, true);
      player = new FilePlayer( myFile );
      player.patch(out);
      player.play();
      println("currentPlaybackIndex :" +  currentPlaybackIndex);
    }
  } else {
    if (recordingStatus == "play") {
      currentPlaybackIndex = 0;
      String fileName = "data/" + currentPlaybackIndex + ".wav";
      AudioRecordingStream myFile = minim.loadFileStream( fileName, 1024, true);
      player = new FilePlayer( myFile );
      player.patch(out);
      player.play();
    } 
  }
  
  
}
