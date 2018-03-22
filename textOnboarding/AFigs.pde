// abstract Figures and Interfaces
interface IDraw{  
  void draw();
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

abstract class Figure2D<T extends Point2D> extends Point2D implements IDraw{  
  // delete Point2D
  T fig;
  color c;
  Figure2D(T p, color c){
    super(p.x, p.y);
    fig = p;
    //fig = new T();
    this.c = c;
  }
  
  // void setXY(Traction tt){
    //tt
  // }
  abstract void draw();
}

interface IUpd{
  void upd(int dms);
}

interface ITraction extends IUpd{  
  Point2D tracXY();
  void setXY(Point2D obj);
}


abstract class Traction<TR_F extends Point2D> implements ITraction{
  float v;
  abstract void upd(int ms);
  
  TR_F trac;  
  Point2D pT;  
  Traction(TR_F trac, float v){
    //this = (TR_F) p;
    //super(trac.x, trac.y);
    this.trac = trac;
    this.v    = v;
    pT        = new Point2D(0,0);
  }
  
  abstract Point2D tracXY();  
  //abstract void setXY(Point2D obj);
  
  void setXY(Point2D obj){
    obj.x = pT.x;
    obj.y = pT.y;
  }
}

class TR_Circle extends Traction<Circle>{
  TR_Circle(Circle c, float v){    
    super(c,  v);  
  }
  
  float angle = 0;
  
  boolean up;
  void upd(int ms){
    up = true;
    angle += v * ms;
    angle %= 2 * PI;
    tracXY();
  }
  
  Point2D tracXY(){ // get XY on the traction
    if (up){      
      pT.x = trac.x + cos(angle) * trac.rad;
      pT.y = trac.y + sin(angle) * trac.rad;
      up = false;
    }
    return pT;
  }    
}