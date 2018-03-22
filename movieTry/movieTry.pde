  
import processing.video.*;
Movie myMovie;

void setup(){
  size(600,600);
  myMovie = new Movie(this, "boss.mp4");
  myMovie.loop();
}

void draw(){
}