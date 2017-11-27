public class Rect{
  public float x1,y1,w,h;
  public color c;
  
  Rect(float x1, float y1, float w,float h, color c){
    this.x1 = x1;
    this.y1 = y1;
    this.w  = w;
    this.h  = h;
    this.c  = c;
  };
  
  void draw(){
    fill(c);
    rect(x1,y1,w,h);
  }
};

class LiquedRect extends Rect{
  public float dw;
  
  public float d; //manipulated
  
  public boolean isControlled=false, isHoriz;
  
  ArrayList<Rect> rs = new ArrayList<Rect>(0);
  int hq;
  LiquedRect(float x1, float y1, float w, float h, float dw, boolean isControlled, boolean isHoriz){
    super(x1,y1,w,h,0);
             
    this.dw = dw;
    this.isControlled = isControlled;
    this.isHoriz      = isHoriz;
    
    this.genRects();
  }
  
  void genRects(){
    rs = new ArrayList<Rect>(0);
    
    if (isHoriz){
      hq = ceil( h/dw);
      
      for(int i =0; i<hq; i++){
        color cr;
        if ((i%2) == 1)
          cr = color(255);
        else
          cr = color(0);
        
        
        float y_1 = (d + i*dw )%w;        
        float y_2 = (d + (i+1)*dw) %w;
        
        if (y_2 < y_1){
          // draw two rects
        } else         
        if ((y_1 < 0) && (y_2 > 0)){
          rs.add(new Rect(x1,h-y_1,w,abs(y_1),c));
          rs.add(new Rect(x1,h-y_1,w,abs(y_1),c));
          // 
        } else {
          if ((y_1 < 0) && (y_2 < 0)){
            y_1 = h - y_1;
            y_2 = h - y_2;
          }
        }
        
        
        
        
        
        if (y_2>this.h)
          y_2 = h;
                
        Rect r = new Rect(0.0, y_1, this.w, y_2 - y_1, cr);
        rs.add(r);
      }
      
      if (w/dw > 0){
    
      }           
    }
    
  }
    
    
  void draw(){
    if (isHoriz){
    }
    
  }
  
};