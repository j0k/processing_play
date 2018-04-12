static interface IND_T{
  static int 
  HORIZONTAL = 0,
  VERTICAL = 1;
}

class RectIndicator extends Point2D implements IDraw{
  float w,h;
  color c;
  int t;
 
  float progress = 100;
  RectIndicator(float x, float y, float w, float h, color c, int t){
    super(x,y);
    this.w = w;
    this.h = h;
    this.c = c;
    this.t = t;
  }
  
  void draw(){
    fill(c);
    switch(t){
      case IND_T.HORIZONTAL:{
        rect(x,y,w * (progress/100),h);
        break;
      }
      case IND_T.VERTICAL:{
        rect(x,y,w,h * (progress/100));
      }
      default:
      break;
    }    
  }
}

RectIndicator attI, medI;

void setupIndicators(){  
  attI = new RectIndicator(0,0, width, 20, color(255,0,100), IND_T.HORIZONTAL);
  medI = new RectIndicator(0,0, 20, height, color(0,255,100), IND_T.VERTICAL);
}

void drawIndicators(){
  attI.draw();
  medI.draw();
}

void indicatorsUp(PsyDyn metrics){
  attI.progress = metrics.get_att();
  medI.progress = metrics.get_med();
}