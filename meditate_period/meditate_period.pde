  
import processing.sound.*;
SoundFile file;

int n = 200;
float f = 120;

float q = 1.011;


float t0, t1;

float[] periods, times;
void setup(){
  f = 15;
  q = 1.2;
  t0 = millis();
  
  periods = new float [n];
  periods[0] = f;
  for(int i = 1; i< n;i++){
    periods[i] = periods[i-1] * q;
  }
  
  times = new float [n];
  times[0] = 0;
  for(int i = 1; i< n;i++){
    times[i] = times[i-1] + periods[i-1];
  }
  
  for(int i = 0; i< n;i++){
    String outtext = str(times[i]/60) + " min; " + str( times[i]) + " sec;";
    if (i>0)
      outtext = outtext + " " + str(times[i]-times[i-1]) + " dtsec";
    
    if (times[i] > 60 * 10)
        q = 1.1;
    println(outtext);
  }
  
  size(400,400);
  file = new SoundFile(this, "relax.mp3");
}

int in=0;

String out = "";
void draw(){

  
  t1 = times[in];
  
  background(0);
  if (t0 + t1 * 1000 < millis()){
    if (in < n-1){ 
      in ++ ;
      out = str(in);
      file.play();
      //String cmd = "PowerShell -Command \"Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('" +nf(in)+" ');\"";
      //launch(cmd);
      
    }
    else 
      out = "end";
    
  }
   
  textSize(30);
  text(out, 50,50);
}
