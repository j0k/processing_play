class Imaginative extends Rect implements IDraw{
  PImage img;
  PImage imgStar;
  PGraphics pg;
  boolean t=false; // false - negative, true - positive
  
  float progress = 0;
  float hardness = 1;
  boolean active = false;
  boolean achieved = false;
  boolean feedbacked = false;
  float VP = 1.0/100; // velocity of the progress per MS
  
  int[] seq; 
  Imaginative(float w, float h, boolean t, String fn, float hardness){
    super(0,0,w,h);
    this.t = t;
    this.hardness = hardness;
    img = loadImage(fn);
    imgStar = loadImage("star.png");
    
    pg  = createGraphics((int) w, (int) h);
    seq = randSeq(3);
    //printSeq(seq);
  }
  
  float scale(PsyDyn metrics){
     return (t) ? metrics.get_att()/hardness: metrics.get_med()/hardness;      
  }
  
  void drawInd(){
    fill(120);
    rect(x,y-30,w*(progress/100),10);
    fill(255);
    rect(x+w*(progress/100),y-30,w*(1 - progress/100),10);  
  }
  
  int[] tc = {255, 255, 255};
  int tci; // tint color index
  void draw(){   
    if (active){
      drawInd();
    }
    
    if (active){
      if (t){
        fill(0,255 * (progress/100),0);
        
        if (img != null){
          pg.beginDraw();
          pg.background(0);
          pg.tint(255 * progress/100, 255);
          pg.image(img,0,0,w,h); 
          pg.endDraw();
      
          image(pg, x, y);
        }
      } else {
        fill(230 - 230 * (progress/100),0,0);
                    
          if (tci<=2){            
            tci = (int) ((progress * 3) /100);
            if (tci>2)
              tci  = 2;
            int ind = seq[tci];
            
            if (progress == 100)
              tc[ind] = 0;
            else tc[ind] = 255 - (int)((progress * 3) % 100) * 255 / 100;
            printSeq(tc);            
          }
          pg.beginDraw();
          pg.background(0);
          pg.tint(tc[0], tc[1], tc[2], 255);
          pg.image(img,0,0,w,h); 
          pg.endDraw();
      
          image(pg, x, y);
      }
      
      if (achieved)
      {
        int dt = 2000;
        
        int hardM = (int) hardness;
        float aw = w/4;
        float ax = x + w/2 - aw * hardM/2.0;
        float ay = y + h/2;
        
        for(int i=0;i<hardM;i++){
          image(imgStar, ax, ay, aw, aw);
          ax += aw;
        }
        
        
        
        if (timer.on_timer_N(1,dt,1)){
          feedbacked = true;
        }
      }
      
      
    } else {
      // if active
      fill(100);
      rect(x,y,w,h);  
    }
    
  }
}