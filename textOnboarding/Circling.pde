


//class Figure2D extends Point2D implements IDraw{
//  Figure2D(Point2D p){
//    super(p.x, p.y);
//  }
//  void draw(){};
//}


//class CircleTR extends Circle implements ITraction{


interface Animation{ // Animation Parameter    
  void upd(int dms);
  void draw();
}



abstract class A1PS extends Point2D implements Animation{ // Anima
  float p, v; // param, v - speed for param changing [V per ms]
  float pM; // maximum for parameter
  A1PS(float x, float y, float p, float pM, float v){
    super(x,y);
    this.p = p;
    this.v = v;
    this.pM = pM;
  }
  
  void upd(int dms){
    p += v * dms;
    p %= pM;
  }
  
  abstract void draw();
}

class byEllipse extends A1PS{
  byEllipse(float x, float y, float p, float pM, float v, float rad){
    super(x,y,p,pM,v);   
  }
  void draw(){
    
  }
}

//class Circling extends A1PS{   
//  float sp = 0;
//  float alpha = 0;
//  Circling(float x, float y, float sp){
//    super(x,y);
//    this.sp = sp;    
//  }
//}



//MyEllipse<A1PS>
// I WANT THIS
//Animate<byEllipse, Rect1> rect1 = new Animate<byEllipse, Rect1>(x,y,rad,v, new Rect1(0,0,40,40));

// rect1.x 
// rect1.o.x
// rect1.o.y




class AnimIt<TT extends Traction, TFig extends Figure2D>  implements Animation{ 
  // TT - T Track.
  // TFig - T Figure.  
  TFig fig;
  TT   tt;
  AnimIt(TT tt, TFig fig){
    //super()
    this.tt  = tt;
    this.fig = fig;
  }
  
  void upd(int dms){
    tt.upd(dms);
    tt.setXY(fig);
    //fig.setXY(tt); // (Point2D)
  }
  
  void draw(){
    fig.draw();
  }    
}

AnimIt<TR_Circle, FCircle> anim1 = new AnimIt<TR_Circle, FCircle>(new TR_Circle(new Circle(200,200,130), 0.002), new FCircle(0,0,40,255)); 


// AnimIt<TR_Circle, FCircle> anim1 = new AnimIt<TR_Circle, FCircle>(new TR_Circle(new Circle(200,200,130), 0.002), new FCircle(0,0,40,255));
//anim2 = new AnimIt<TR_Circle, FCircle>(, new FCircle(0,0,40,255));