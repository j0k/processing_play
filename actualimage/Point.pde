interface IDraw{  
  void draw();
}

interface IReset{
  void reset();
}

interface IDragged{
  // boolean dragged = false;
  boolean mouseInside();
}

interface IUp{
  void up(Timing dt);  
}

interface XYChoords{
  void setXY(Point2D p);
}

interface IPoint2D{
  Point2D getC();
  float X();
  float Y();
}

class Point2D implements XYChoords, IPoint2D{
  float x, y;
  
  Point2D(float x, float y){
    this.x = x;
    this.y = y;
  }
 
  void setXY(Point2D p){
    this.x = p.x;
    this.y = p.y;
  }
  
  float X(){
    return x;
  }
  
  float Y(){
    return y;
  }
  
  Point2D getC(){
    return this;
  }
}

class Circle extends Point2D{
  float rad;
  Circle(Point2D p, float rad){
    super(p.x, p.y);
    this.rad = rad;
  }
  
  Circle(float x, float y, float rad){
    super(x, y);
    this.rad = rad;
  }  
}

class Rect extends Point2D{
  float w,h;
  Rect(Point2D p, float w, float h){
    super(p.x, p.y);
    this.w = w;
    this.h = h;
  }
  
  Rect(float x, float y, float w, float h){
    super(x, y);
    this.w = w;
    this.h = h;
  }
}

class Timing{
  int time = 0;
  int dt = 0;
  
  void up_time(int new_time){
    dt = new_time - time;
    time = new_time;
  }
}