class Rect extends Point2D {
  //float x,y; // center;
  float x2,y2,w,h;
  Rect(float x1, float y1, float x2, float y2){
    super( (x1+x2)/2.0, (y1+y2)/2.0);
    this.x = x1;
    this.x2 = x2;
    this.y = y1;
    this.y2 = y2;
    this.w = x2-x1;
    this.h = y2-y1;
  }
  
  Point2D getC(){
    return new Point2D((x+x2)/2, (y+y2)/2);
  }
  
  float X(){
    return (x+x2)/2;
  }
  
  float Y(){
    return (y+y2)/2;
  }
}

boolean inside(float x, float y, Rect r){
  return ((r.x <= x) && (r.x2 >= x)) && ((r.y <= y) && (r.y2 >= y));    
}