
float x1,y1,x2,y2;
float cx,cy;
 
void setup()
{
   size(600,600);
}
 
void init()
{
   x1 = (int)random(100,500);
   y1 = (int)random(100,500);
   x2 = (int)random(100,500);
   y2 = (int)random(100,500);
   cx = (int)random(100,500);
   cy = (int)random(100,500);   
}   

PVector Projection(PVector line_p1, PVector line_p2, PVector p){
  float y1 = line_p1.y;
  float y2 = line_p2.y;
  float x1 = line_p1.x;
  float x2 = line_p2.x;
  
  if ((x1 == x2) && (y1 == y2))
    return new PVector(x1,y1);
    
  float k = ((y2-y1) * (cx-x1) - (x2-x1) * (cy-y1)) / (sq(y2-y1) + sq(x2-x1));
  float x4 = p.x - k * (y2-y1);
  float y4 = p.y + k * (x2-x1);
  
  return new PVector(x4,y4);
}

void draw()
{
  background(60);
  init();
  stroke(220);
  line(x1,y1,x2,y2);
  noFill();
  ellipse(cx,cy,50,50);
  noStroke();
  fill(220,20,20);
  ellipse(cx,cy,8,8);
  // calculate the point
  
  PVector proj = Projection(new PVector(x1,y1), new PVector(x2,y2), new PVector(cx,cy));
  
  float x4 = proj.x;
  float y4 = proj.y;
  fill(20,20,220);
  ellipse(x4,y4, 8,8);
  stroke(0);
  line(cx,cy,x4,y4);
  noLoop();
}
 
void keyPressed() { loop(); }  