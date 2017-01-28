class PointBound{
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
    if ((b1 < PI) )
      b1 += step;
  
    if (b2 < PI){
      b2 += step;
      
      if((b2-b1) < HALF_PI){
        b2 += step;
      }
    }
  
    if (b1 >= PI){
      b1 = 0;
      b2 = 0;
    }  
    
    
  }
}