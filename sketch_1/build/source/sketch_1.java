import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_1 extends PApplet {

// https://www.openprocessing.org/sketch/396923

// arc, PI, strokeCap, revolve, ellipse
// An animation of a still graphic I saw on-line somewhere.
// Click to toggle background black/white

float move;
boolean isBlkbg;

public void setup() {
  
  noFill();
  strokeCap(SQUARE);
  isBlkbg = true;
}

public void draw() {
  if (isBlkbg) background(50);
  else background(245);
  drawShape(500, move);
  drawShape(450, move*.6f);
  drawShape(400, move*.9f);
  drawShape(350, move*1.5f);
  move += .01f;
}

public void drawShape(float sze, float incr) {
  if (isBlkbg) stroke(245, 100);
  else stroke(50, 50);
  strokeWeight(.5f);
  ellipse(width/2, height/2, sze, sze);
  if (isBlkbg)stroke(245);
  else stroke(50);
  strokeWeight(3);
  arc(width/2, height/2, sze, sze, incr, incr+ PI);
  strokeWeight(15);
  arc(width/2, height/2, sze, sze, -incr, -incr+PI/2.0f);
  strokeWeight(25);
  arc(width/2, height/2, sze, sze, incr/2, incr/2+PI/6);
}

public void mousePressed() {
  isBlkbg = !isBlkbg;
}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
