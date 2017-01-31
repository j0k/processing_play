class PointBound implements Comparable<PointBound> {
  public float PB_PI = PI - 0.15;
  public float b1, b2;
  public int w,h,ycen,xcen;
  public color c;
  public int sw=1; //strokeWeight
  public float step=0.01;
  
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