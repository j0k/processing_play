PFont font;

AnimIt<TR_Circle, FCircle> animText;

void setup(){
  size(600,600);
  background(120);
  font = createFont("Radomir_Tinkov__QanelasSoft_Light.otf", 32);
  textFont(font);
  animText = new AnimIt<TR_Circle, FCircle>(new TR_Circle(new Circle(width/2, height/2,130), 0.0015), new FCircle(0,0,20,255));
}



float tx = 120,ty = 120;
int lastTime = millis();
int dms = 0;
void draw(){
  if (mousePressed)
  return;
  dms = millis() - lastTime;
  lastTime = millis();
  
  background(120);
  anim1.upd(dms);
  animText.upd(dms);
  anim1.draw();
  
  textSize(30);
  String t = "Hello! ppp";
  //text(t, tx, ty);
  
  //drawTextBox(t, tx, ty);
  if (mX != -1){
    lineFromTo(new Point2D(tx, ty), new Point2D(px, py));
    //lineFromTo(new Point2D(anim1.fig.x, anim1.fig.y), new Point2D(px, py));    
    
    text(t, animText.fig.x, animText.fig.y);
    Rect tb = textBox(t, animText.fig.x, animText.fig.y);
    drawBox(tb);
    
    lineFromTo(tb, new Point2D(px, py));
    circling();
  }
}

Rect textBox(String t, float tx, float ty){     
  float tw = textWidth(t);
  
  float ta = textAscent();
  float td = textDescent();
  
  float xl = tx, xr = tx + tw;
  float yt = ty - ta;
  float yb = ty + td;
  
  return new Rect(xl,yt,xr,yb);
}

void drawBox(Rect r){
  noFill();
  rect(r.x, r.y, r.w, r.h);
  strokeWeight(3);
  stroke(255);
  line(r.x-5, r.y2+3, r.x2+5, r.y2+3);
}


void lineFromTo(Rect r, Point2D p2){
  float p1x, p1y;
  
  boolean inX = false, inY = false;
  if (p2.x > r.x2)
    p1x = r.x2;
  else if (p2.x < r.x)
    p1x = r.x;
  else {
    p1x = p2.x;
    inX = true;
  };
  
  // p1x = r.x2 - r.w/2
  if (p2.y > r.y2)
    p1y = r.y2;
  else if (p2.y < r.y)
    p1y = r.y;
  else {
    p1y = p2.y;
    inY = true;
  }
  
  if(!inY)
    p1x = r.X();
    
  //if(!inX)
  //  p1y = r.Y();
  
  
  lineFromTo(new Point2D(p1x,p1y), p2);
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

float mX = -1, mY = -1;
void mousePressed(){  
  mX = mouseX;
  mY = mouseY;  
}

float rad = 50, r = 20;
float alpha = 0;
float px = 0,py = 0;
float sp = 0.09;
void circling(){
  px = cos(alpha) * 2 * rad + mX;
  py = sin(alpha) * rad + mY;
  alpha += sp;
  alpha %= 2*PI;
  ellipse(px,py, r,r);
}