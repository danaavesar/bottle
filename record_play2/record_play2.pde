import ddf.minim.*;
import ddf.minim.ugens.*;
import processing.serial.*;

Serial myPort;
Minim minim;

// for recording
AudioInput in;
AudioRecorder recorder;

// for playing back
AudioOutput out;
FilePlayer player;

String countname; 
String name = "00"; 
String myString;
String val[];
String pVal[];
int linefeed = 10;
int numberOfRecordings;

void newFile(){      
 countname = name + "1";
 recorder = minim.createRecorder(in, "data/" + countname + ".wav");
}

void setup(){
  size(512, 200, P3D);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048);
  newFile();
  
  out = minim.getLineOut( Minim.STEREO );
  textFont(createFont("Arial", 12));
  
  String portName = Serial.list()[3]; 
  //println(Serial.list()[3]);
  myPort = new Serial(this, portName, 9600); 
  myPort.bufferUntil(linefeed);
}


void serialEvent(Serial myPort){
    myString = myPort.readStringUntil(linefeed);
    myString = trim(myString);
    val = split(myString, ",");
}


void draw(){
  background(0); 
  stroke(255);
  
  if(val != null){  
    if(val[0].equals("0") && pVal[0].equals("1")){
       if ( recorder.isRecording() ) {
         recorder.endRecord();
         if ( player != null ){
           player.unpatch( out );
           player.close();
         }
         player = new FilePlayer( recorder.save() );
         player.patch(out);
         player.play();
         player.loop(); 
       }
       else {
         newFile();
         numberOfRecordings++;
         println(numberOfRecordings);
         recorder.beginRecord();
       }
   }
   
   if ( val[1].equals("0") && pVal[1].equals("1") ){
    
   }
   pVal = split(myString, ",");
 }
      
  for(int i = 0; i < in.left.size()-1; i++){
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
  
  if ( recorder.isRecording() ){
    text("Now recording...", 5, 15);
  }
  else{
    text("Not recording.", 5, 15);
  }
}


