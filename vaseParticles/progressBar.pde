
class ProgressBar{
  int x;
  int y;
  int wi;
  int hi;
  float vmax;
  
  //int 
  float curValue;
  color c;
  
  color bc;
  
  ProgressBar(int x,int y, int wi, int hi, color c, color bc, float vmax){
    this.x = x;
    this.y = y;
    this.wi = wi;
    this.hi = hi;
    this.c = c;
    this.bc = bc;
    this.vmax = vmax;
  }
  
  public void setValue(float v){
    curValue =  min(v,vmax);
    //if (v>
  }
  
  
  
  void draw(){
    stroke(bc);
    
    line(this.x,this.y-4,this.x,this.y+4);
    line(this.x+wi,this.y-4,this.x+wi,this.y+4);
    line(this.x,y,x+wi,y);
    
    int m = 30;
     
    for(int i=0; i<m; i++){
      int opp = (int) lerpBounds(0,100,((float) i)/m, 0.8, 0.3,1);
      //println(opp);
      color c = colorOppacity(bc, opp );
      stroke(c);
      //int rad = (int) map(i,0,m,0,18);
      int rad = (int) lerpBounds(0,m,((float) i)/m, 0.8,0.5,1);
      //int opp
      // fill(color(0,255 * ((float)i/m),0 * ((float)i/m)));
      //fill(color(0,255 * ((float)i/m),0,100));
      color tmpc = color(0,255,0);
      
      //float g2 = tmpc >> 8 & 0xFF;  // Very fast to calculate
      fill(c);//colorOppacity(bc, (int) (100*((float) i)/m) ));
      //;
      //tint(255,255,255,255 * ((float)(i/m)));
      ellipse(lerp(this.x, this.x+map(curValue,0,vmax,0,wi), (float)i/m), y, rad, rad);
    }
    
    fill(0);
  }
}

ProgressBar[] bars;

color colorOppacity(color c, int o){
  // o is in [0,255]
  int r = c >> 16 & 0xFF;  // Very fast to calculate
  int g = c >> 8 & 0xFF;  // Very fast to calculate
  int b = c & 0xFF;  // Very fast to calculate
  
  return color(r,g,b,o);
}

void initProgressBars(){
  bars = new ProgressBar[2];
  
  for(int i=0; i < bars.length ; i++){
  
  }
  bars[0] = new ProgressBar(20,(int) (height * 0.94), 120,10,color(0,255,0), color(0,255,0),1);
  bars[1] = new ProgressBar(210,(int) (height * 0.94), 120,10,color(0,0,255), color(0,0,255),1);
}

void updateProgressBars(){
  bars[0].setValue(levelVase);
  bars[1].setValue(map(dtSpeedGen/1000,0,1,1,0));
  for(int i=0; i < bars.length ; i++){
    //bars[i].setValue(levelVase);
    //levelVase
    bars[i].draw();
  }
}