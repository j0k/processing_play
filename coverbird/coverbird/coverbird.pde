PImage img_bird, img_cage;

void setup() {
  size(600,600);
  // Images must be in the "data" directory to load correctly
  img_bird = loadImage("bird.jpg");
  img_cage = loadImage("cage.jpg");
  
}

void draw_bird(){
  image(img_bird, 0, 20, width * 9/10, height * 0.9);
}

void draw_cage(){
  image(img_cage, 0, 0, width, height);
}

boolean t = true;

float last_time = millis();
void draw() {
  if (abs(last_time - millis()) > freq){
    t = !t;
    last_time = millis();
  }
    
  if (t)
    draw_bird();
  else
    draw_cage();
}

void mouseReleased() {
  t = !t;
}

float freq=100;

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      freq += 1;
    } else if (keyCode == DOWN) {
      freq -= 1;
    } 
  }
}