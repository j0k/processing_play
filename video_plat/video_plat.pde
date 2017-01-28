  

import processing.video.*;
Movie myMovie;

void setup() {
  size(200, 200);
  frameRate(30);
  myMovie = new Movie(this, "clip03.mov");
  myMovie.speed(10);
  myMovie.loop();
}

void draw() {
  //image(myMovie, 0, 0);
  if (myMovie.available()) {
    myMovie.read();
  }
  image(myMovie, 0, 0);
}

//void movieEvent(Movie m) {
  //m.read();
//}