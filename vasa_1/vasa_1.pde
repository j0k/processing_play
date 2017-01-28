PImage img;
int ybase = 55;

void setup(){
  size(400,400);
  noFill();
  
  img = loadImage("tusion_logo.png");
  bounds = new ArrayList<PointBound>();
}

int xcen_left=80, xcen_right=140;
int ycen=120;

int img_x=10, img_y=10, img_width=200, img_height=200;

boolean speed_balance = false;
boolean bounds_balance = false;
void draw(){
  color c = color(255, 204, 0);
  color(c);
  
  image(img, img_x, img_y, img_width, img_height);
  stroke(c); 
  
  draw_arc_line();
  
  for(int i =0; i<bounds.size();i++)
    {
      bounds.get(i).draw();
      bounds.get(i).update();
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
  pb.sw = round(1+random(1));
  
  return pb;
}


float t=0;
void mousePressed() {
  
  println("x = " + mouseX + " ; y = " + mouseY);
  bounds.add(add_arc(110, mouseY, abs(110-mouseX)*2, abs(110-mouseX)*2/3, random(0.10)));
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
    avg_speed = speed;
  }
  
  for(int i =0; i<bounds.size();i++)
    {
      bounds.get(i).step = to_speed(avg_speed, avg_speed - bounds.get(i).step, 0.000001);
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


void keyReleased()
{
  if (key == CODED) {
    if (keyCode == UP) {
      speed_balance = true;
      print("UP");   
    } else if (keyCode == DOWN) {
       bounds_balance = true;
    } else if (keyCode == LEFT) {
      set_width_stroke(4);
    }
  }
}

void exit() {
  println("exiting");
  super.exit();
}