class PointBound implements Comparable<PointBound> {
  public float PB_PI = PI - 0.15;
  public float b1, b2;
  public int w,h,ycen,xcen;
  public color c;
  public int sw=strokeWeight; //strokeWeight
  public float stepdef=0.02;
  public float step=0.02;
  
  public void draw(){
    stroke(this.c);
    strokeWeight(sw);
    arc(xcen, ycen, w, h, b1, b2);
  }
  
  public void update(){
    
    if ((b1 < PB_PI) )
      b1 += step;
  
    if (b2 < PB_PI){
      b2 += step;
      
      if((b2-b1) < HALF_PI){
        b2 += step;
      }
    }
  
    if (b1 >= PB_PI){
      b1 = 0;
      b2 = 0;
    }  
    
  }
  
  // compare
  // http://stackoverflow.com/questions/18441846/how-to-sort-an-arraylist-in-java
  @Override
  public int compareTo(final PointBound pb) {    
    if (this.ycen < pb.ycen)
      return 1;
    else 
      return -1;

  }
}

color pbDefColor = color(0,0,0);
boolean colorizing = false;
int strokeWeight = 1;
PointBound add_arc(int xcen, int ycen, int w, int h, float step){
  
  PointBound pb = new PointBound();
  pb.xcen = xcen;
  pb.ycen = ycen;
  pb.w = w;
  pb.h = h;
  pb.b1 = 0;
  pb.b2 = HALF_PI;
  pb.step = step;
  if (colorizing)
    pb.c = color(round(random(255)), round(random(255)), round(random(255)));
  else
    pb.c = pbDefColor;
  pb.sw = round(1+random(1));
  
  return pb;
}