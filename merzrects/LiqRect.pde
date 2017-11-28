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
  
  boolean in(float x, float y){
    return ((x>=x1) && (x<=x1+w) && (y >=y1) && (y <=y1+h));
  }
  
  boolean mouseIn(){
    return in(mouseX,mouseY);
  }
};

class LiquedRect extends Rect{
  public float dw = 10;
  
  public float d = 0; //manipulated
  public float speed = 0; //manipulated
  
  public boolean isW = false;
  
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
        
        
        float y_1 = (d + i*dw )%h;        
        float y_2 = (d + (i+1)*dw) %h;
        
        if ((y_1 < 0) && (y_2 < 2)){
          y_1 = h - abs(y_1);
          y_2 = h - abs(y_2);
        }
        
        if ((y_1 >=0) && (y_2>=0) && (y_1<y_2) && (y_2 <= h)){
          rs.add(new Rect(0,y_1,w,dw,cr));            
        }
        if ((y_1 >=0) && (y_2>=0) && (y_2 < y_1)){
          rs.add(new Rect(0,y_1,w,h-y_1,cr));
          rs.add(new Rect(0,0,w,y_2,cr));
          // draw two rects
        } else         
        if ((y_1 <= 0) && (y_2 >= 0)){
          y_1 = abs(y_1);
          rs.add(new Rect(0,h-y_1,w,abs(y_1),cr));
          rs.add(new Rect(0,0,w,y_2,cr));
          // 
        } 
               
      }
      
      if (w/dw > 0){
    
      }           
    }
    
  }
    
  void update(){
    if (isW)
      d += speed;
    if (speed != 0)
      genRects();
    
    if (dtEps()){ 
      if (mousePressed & mouseIn()){      
        isW = isW ^ true;
        upEps();
      }
    }
  }
  
  void draw(){
    pushMatrix();
    translate(x1, y1);
    for(int i = 0 ; i< rs.size(); i++){
      rs.get(i).draw();
      
    }
    popMatrix();
    if (isHoriz){
    }
    
  }
  
};