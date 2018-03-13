void setup(){
  size(600,600);
  background(120);
}

class Point2D{
  float x, y;
  
  Point2D(float x, float y){
    this.x = x;
    this.y = y;
  }
  
}

float tx = 120,ty = 120;
void draw(){
  
  textSize(30);
  String t = "Hello! ppp";
  text(t, tx, ty);
  
  drawTextBox(t, tx, ty);
}

void drawTextBox(String t, float tx, float ty){
     
  float tw = textWidth(t);
  
  float ta = textAscent();
  float td = textDescent();
  
  float xl = tx, xr = tx + textWidth(t);
  float yt = ty - ta;
  float yb = ty + td;
  
  strokeWeight(1);
  // line below
  line(xl, yb, xr, yb);
  // line upline
  line(xl, yt, xr, yt); 
  
  //left line
  line(xl, yt, xl, yb); 
  //right line
  line(xr, yt, xr, yb);
  
  strokeWeight(3);
  stroke(255);
  line(xl-5, yb+3, xr+5, yb+3);
}

void lineFromTo(Point2D p1, Point2D p2){
  //   I  | II
  // ----------
  //  III | IV
  int r  = (p1.x < p2.x)?1:0;
  int b  = (p1.y < p2.y)?1:0;
  
  float dx = p1.x - p2.x;
  float dy = p1.y - p2.y;
  
  boolean toX = (abs(dx) < abs(dy))?true:false; 
  
  int segment = b*2 + r; // 0,1,2,3 (I,II,III,IV) seg
  float x1=p1.x,x2=0,x3=p2.x,y1=p1.y,y2=0,y3=p2.y;
  
  if (!toX){ // [to horizon]
   x2 = p1.x + 2*(p2.x - p1.x)/3;
   y2 = p1.y;
  } // else [to vertical]
  else {
   y2 = p1.y + 2*(p2.y - p1.y)/3;
   x2 = p1.x;
  }
  
  switch(segment){
    case 0: break;
    case 1: break;
    case 2: break;
    case 3: break;
  }
  
  stroke(color(255,120,120));
  line(x1,y1,x2,y2);
  stroke(color(120,255,120));
  line(x2,y2,x3,y3);
}

void lineFromRToP(Rect r, Point2D p){
}
void mousePressed(){  
  lineFromTo(new Point2D(tx, ty), new Point2D(mouseX, mouseY));
}