  
import processing.video.*;
Movie myMovie;

void setup(){
  size(600,600);
  myMovie = new Movie(this, "boss.mp4");
  myMovie.loop();
}

void draw(){
  tint(255, 20);
  image(myMovie, 0, 0, 200,200);
}

void movieEvent(Movie m) {
  m.read();
}