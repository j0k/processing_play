PFont font;

AnimIt<TR_Circle, FCircle> animText;
onBoard board = new onBoard();
void setup(){
  size(700, 700);
  background(120);
  font = createFont("Radomir_Tinkov__QanelasSoft_Light.otf", 32);
  textFont(font);
  animText = new AnimIt<TR_Circle, FCircle>(new TR_Circle(new Circle(width/2, height/2,130), 0.0015), new FCircle(0,0,20,255));
  
  {
    // board init
      board.symbPerLine = 20;
    
    board.elems.add( new onBoardElem(new Point2D(200,200), "Yes!", new Point2D(0,0), board));
    board.elems.add( new onBoardElem(new Point2D(200,200), "Hellooo a very coooool world!!!! you are sooooo cool!", new Point2D(width,0), board));
    board.elems.add( new onBoardElem(new Point2D(200,200), "Hellooo a very cosadfdsfds fdsf sdf aooool world!!!! you vsf dsfg df gd are sooooo cool!", new Point2D(width,height), board));
    board.elems.add( new onBoardElem(new Point2D(200,200), "Hi", new Point2D(0,height), board));
    board.elems.add( new onBoardElem(new Point2D(200,200), "He are sooooo cool!", null, board));
    
    board.init();
  }
  
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
    //lineFromTo(new Point2D(tx, ty), new Point2D(px, py));
    //lineFromTo(new Point2D(anim1.fig.x, anim1.fig.y), new Point2D(px, py));    
    
    //text(t, animText.fig.x, animText.fig.y);
    //Rect tb = textBox(t, animText.fig.x, animText.fig.y);
    //drawBox(tb);
    
    //lineFromTo(tb, new Point2D(px, py));
    //circling();
  }
  
  board.upd(dms);
  board.draw();
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


void lineFromTo(Rect r, Point2D p2, float perc){
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
  
  //if(!inY)
  //  p1x = r.X();
    
  if(!inX)
    p1y = r.Y();
    
  lineFromTo(new Point2D(p1x,p1y), p2, perc);
}

void lineFromTo(Point2D p1, Point2D p2){
  lineFromTo(p1, p2, 1.00);
}

void lineFromTo(Point2D p1, Point2D p2, float perc){
  // perc = 0 .. 0.5 .. 1.00
  //   I  | II
  // ----------
  //  III | IV
  int r  = (p1.x < p2.x) ? 1 : 0;
  int b  = (p1.y < p2.y) ? 1 : 0;
  
  float dx = p1.x - p2.x;
  float dy = p1.y - p2.y;
  
  boolean toX = (abs(dx) < abs(dy)) ? true : false; 
  
  int segment = b*2 + r; // 0,1,2,3 (I,II,III,IV) seg
  float x1=p1.x, x2=0, x3=p2.x, y1=p1.y, y2=0, y3=p2.y;
  
  if (!toX){ // [to horizon]
   x2 = p1.x + 2.0*(p2.x - p1.x)/3;
   y2 = p1.y;
  } // else [to vertical]
  else {
   y2 = p1.y + 2.0*(p2.y - p1.y)/3;
   x2 = p1.x;
  }
  
  switch(segment){
    case 0: break;
    case 1: break;
    case 2: break;
    case 3: break;
  }
  
  if ((perc > 0.99) && (perc <= 1.01)){    
    stroke(color(255,120,120));
    line(x1,y1,x2,y2);      
    line(x2,y2,x3,y3);
  } else {    
    float d1 = dist(x1,y1,x2,y2);
    float d2 = dist(x2,y2,x3,y3);
    float dA = d1 + d2;
    if (dA * perc <= d1){
      float pp = (dA * perc / d1);
      stroke(color(255,120,120));
      linePerc(x1, y1, x2, y2, pp);      
    } else {
      stroke(color(255,120,120));
      
      line(x1, y1, x2, y2);
      
      float pp = ((dA * perc - d1) / d2);      
      
      stroke(color(120,255,120));
      linePerc(x2,y2,x3,y3,pp);
      //line(x2,y2,x3,y3);
    }    
    
    
  }
}

void lineFromRToP(Rect r, Point2D p){
}

void linePerc(float x1, float y1, float x2, float y2, float p){
  line(x1, y1, x1 + (x2-x1)*p, y1 + (y2 - y1)*p);  
}

float mX = -1, mY = -1;
void mousePressed(){  
  mX = mouseX;
  mY = mouseY;
  board.checkMouse();
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