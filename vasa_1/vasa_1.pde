import java.util.Collections;
import java.util.Comparator;

PImage img, imgLF, imgRF, imgWhite;
int ybase = 55;

float A = 100, M = 100;
ImagePlastic vasa, leftFace, rightFace, vasaWhite;
StageController stage;

void setup(){
  size(500,500);
  noFill();
  
  stage = new StageController(); 
  img = loadImage("tusion_logo.png");
  imgWhite = loadImage("tusion_logo_white.png");
  imgLF = loadImage("leftFace.png");
  imgRF = loadImage("rightFace.png");
  
  vasa = new ImagePlastic(img,img_x,img_y,img_width,img_height,100);
  leftFace = new ImagePlastic(imgLF,img_x,img_y,img_width,img_height,200);
  rightFace = new ImagePlastic(imgRF,img_x,img_y,img_width,img_height,200);
  
  bounds = new ArrayList<PointBound>();
  vasaCenX = img_x + img_width/2;
}

int xcen_left=80, xcen_right=140;
int ycen=210;
int vasaCenX;

int img_x=10, img_y=10, img_width=410, img_height=410;

boolean speed_balance = false;
boolean bounds_balance = false;

void draw(){
  background(255);
  color c = color(255, 204, 0);
  color(c);
  
  stage.draw();
  stage.update();
  

  //vasa.loop();
  //noTint();
  //image(img, img_x, img_y, img_width, img_height);
  stroke(c); 
  
  
  //fill(255 - vasa.oppacity);
  //noFill();
  for(int i =0; i<bounds.size();i++)
    {
      bounds.get(i).draw();
      bounds.get(i).update();
      bounds.get(i).c = color(vasa.oppacity);
    }
    
 if (speed_balance){
   start_speed_relax();
 }
 
 if (bounds_balance){
   start_balance_bounds();
 }
}

ArrayList<PointBound> bounds;
float b1=HALF_PI,b2=PI;
float step=0.01; 

void draw_arc_line(){
  arc(110, ycen, 60, 20, b1, b2);
  
  if (b1 < PI)
    b1 += step;
  
  if (b2 < PI)
    b2 += step;
  
  if (b1 >= PI){
    b1 = 0;
    b2 = HALF_PI;
  }
}


PointBound add_arc(int xcen, int ycen, int w, int h, float step){
  
  PointBound pb = new PointBound();
  pb.xcen = xcen;
  pb.ycen = ycen;
  pb.w = w;
  pb.h = h;
  pb.b1 = 0;
  pb.b2 = HALF_PI;
  pb.step = step;
  pb.c = color(round(random(255)), round(random(255)), round(random(255)));
  pb.c = color(255, 255, 255);
  pb.sw = round(1+random(1));
  
  return pb;
}

float t=0;
void mousePressed() {
  println("x = " + mouseX + " ; y = " + mouseY);
  bounds.add(add_arc(vasaCenX, mouseY, abs(vasaCenX-mouseX)*2, abs(vasaCenX-mouseX)*2/3, random(0.10)));
}

float avg_speed = 0;

void start_speed_relax(){
  if (avg_speed <= 0.00001){
  float speed = 0;
   for(int i =0; i<bounds.size();i++)
    {
      speed += bounds.get(i).step;
      //bounds.get(i).update();
    }
    
    speed = speed / bounds.size();
    print(speed + "-sp-");
    if(speed<0)
      speed = - speed;
    avg_speed = speed;
    
  }
  
  for(int i =0; i<bounds.size();i++)
    {
      bounds.get(i).step = to_speed(avg_speed, avg_speed - bounds.get(i).step, 0.00001);
      //bounds.get(i).update();
    }
}

float to_speed(float to_speed, float cur_speed, float iter){
  if (abs(cur_speed - to_speed) <= iter)
     return to_speed;
     
  if (cur_speed > to_speed)
    return cur_speed - iter;
  else  
    return cur_speed + iter;
}

void start_balance_bounds(){
  
  float b1 = 0; 
  float b2 = 0;
  
  for(int i =0; i<bounds.size();i++)
  {
    b1 += bounds.get(i).b1;
    b2 += bounds.get(i).b2;
  }
  
  b1 = b1 / bounds.size();
  b2 = b2 / bounds.size();
  
  for(int i =0; i<bounds.size();i++)
    {
      bounds.get(i).b1 = to_speed(b1, bounds.get(i).b1, 0.01);
      bounds.get(i).b2 = to_speed(b2, bounds.get(i).b2, 0.01);
    }
}

void set_width_stroke(int sw){
  
  for(int i =0; i<bounds.size();i++)
  {
    bounds.get(i).sw = sw;
  }
}

float setVal(float p, float add, float def){
  float newVal = p+add;
  
  if (def<=0){
    if (newVal<def)
      return def;
    else return newVal;
  } else
  if (def>=100)
    if (newVal>=def)
      return def;
    else return newVal;
  
  return def;
}

void keyReleased()
{
  if (key == CODED) {
    if (keyCode == UP) {
      A = setVal(A,10,100);
    } else if (keyCode == DOWN) {
      A = setVal(A,-10,0);
    } else if (keyCode == LEFT) {
      M = setVal(M,-10,0);
    } else if (keyCode == RIGHT) {
      M = setVal(M,10,100);
    }
    print ("A:"+A + " M:"+M + "\n");
  }
  if (key == 'b') {
    AddRandArcs(10);
    print("b");
  } else
  if (key == 'd') {
    RemoveRandArcs(5);
    print("d");
  } else
  if (key == 's') {
    speed_balance = true;    
  } else
  if (key == 'S') {
    speed_balance = false;    
  } else
  if (key == 'a') {
    bounds_balance = true;    
  } else
  if (key == 'A') {
    bounds_balance = false;    
  } else
  if (key == 'f') {
    set_width_stroke(4);    
  } else
  if (key == '1') {
    stage.toStage = 1;    
  } else
  if (key == '2') {
    stage.toStage = 2;    
  } else
  if (key == '3') {
    stage.toStage = 3;    
  } else
  if (key == '4') {
    stage.toStage = 4;    
  } else
  if (key == '5') {
    stage.toStage = 5;    
  } else
  if (key == '6') {
    stage.toStage = 6;    
  }
  
  
}

void exit() {
  println("exiting");
  super.exit();
}