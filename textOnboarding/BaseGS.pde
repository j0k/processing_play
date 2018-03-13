class Rect extends Point2D {
  //float x,y; // center;
  float x1,x2,y1,y2;
  Rect(float x1, float x2, float y1, float y2){
    super((x1+x2)/2, (y1+y2)/2);
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
  }
}