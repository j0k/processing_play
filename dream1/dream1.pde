/*
Tuse: Reflect the Dream
Appear and dissapear dreams symbols
Controls: mouse click to switch to the next image. left, right, up, down - keyboard to change parameters
Author: Yuri Konoplev (TuSion team)
Site: tusion.xyz

Based on Portrait painter
Mimics a brush's stroke to paint a portrait.
Controls: - Mouse click to switch to the next image.
Author:  Jason Labbe
Site: jasonlabbe3d.com
*/

bool go = false;

ImgConfig[] confs;
ImgConfig conf; // current config
//String[] imgNames = {"finesleep.jpg", "cantsleep-min.jpg", "dream2-min.jpg", "tired.jpg"};
PImage img;
int imgIndex = 0;

void setup() {
  size(900, 650);
  
  initConf();
  nextImage();
  hsAtt = new HScrollbar(width/16, height/4, width/4, 16, 16, "Attention", 10,);
  hsMed = new HScrollbar(width/16, height/4 + 32, width/4, 16, 16, "Meditation", 10);
  hsState = new HScrollbar(width/16, height/4 + 64, width/4, 16, 16, "", 10);
  
}


void draw() {
  //image(img, 0, 0, width/2, height/2);
  drawDefImage();
  if (go)
  {
    processImage(conf.strokes, conf.order);  
  }
  
  hsAtt.update();  
  hsAtt.display();
  
  hsMed.update();  
  hsMed.display();
  
  
  {
    hsState.title = "State:" + SM.cs().title + " (" + PSY2S(SM.cs().state) + ")";
    hsState.display();
  }
  
  //SM.update_values(hsAtt.value, hsMed.value);
}


void mousePressed() {
  nextImage();
}

bool toDrawDefImage = false;
void drawDefImage(){
  if (toDrawDefImage && img.width > 0){
    if (conf.drawBegin)
      image(img, 0, 0, width, height);
    toDrawDefImage = false;
    
    xRatio = (float)width/img.width;
    yRatio = (float)height/img.height;
    
    go = true;
    frameCount = 0;
  }
}

void keyPressed() {
  keyPressedScrolls();
}