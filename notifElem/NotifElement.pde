abstract class NotifElem{
  String text;   
  int step = -1;
  
  float tSt;
  public float x,y;
  boolean isTaping=true;
      
  void start(){
    step = 0;
  }
  
  void draw(){
    switch(step){
      case 0:
        // init step
        init();
        tSt = millis();
        step ++;
        break;
      
      case 1:
        // drawing the Achieve Symbol
        processSymbol();
        break;
        
      case 2:
        // drawing the Achieve Symbol
        processText();
        break;
        
      default:
        
    }
    
    drawSymbol();
    drawText();    
  }
  
  abstract void init();
  
  abstract void drawSymbol();
  abstract void processSymbol();
  
  abstract void processText();
  abstract void drawText();    
}


class BallNotif extends NotifElem {
  String title;
  String desc;
  float radius, radiusCur = 0;
  float tSymDuration;
  color c;
  
  float xth, yth, xthd = 10;
  float xtt, ytt, xttd = 10;
  
  int thh, tth, tdh; //textSize
  float tw; 
  BallNotif(float x, float y, float radius, float tSymDuration, color c, String head, int tsh, String title, int tth, String desc, int tdh){
      this.x = x;
      this.y = y;
      xth = x + radius/2 + xthd;
      yth = y ;
      
      this.radius = radius;
      this.tSymDuration = tSymDuration;
      this.c = c;
      
      this.text  = head;
      this.title = title;
      this.desc  = desc;
      
      this.thh = tsh;
      this.tth = tth;
      this.tdh = tdh;
  }
  
  float tsth, tsdh;
  void init(){
    textSize(thh);
    tw = textWidth(text);
    
    textSize(tth);
    float scalar = 0.8; // Different for each font
    tsth = textDescent() * scalar;
    
    textSize(tdh);
    
    tsdh = textDescent() * scalar;        
    // tsth = textHeight(title);
  }
  
  void processSymbol(){
        radiusCur = map(millis(), tSt, tSt + tSymDuration, 0, radius);
        if (radiusCur >= radius){
          step ++;
          radiusCur = radius;
        }        
  }
  
  void drawSymbol(){
    fill(c);
    ellipse(this.x, this.y,radiusCur,radiusCur);
  }
  
  
  void processText(){
    
  }
  
  void drawText(){
    fill(c);
    textSize(thh);
    textAlign(LEFT, CENTER);
    text(text, xth,yth);
    
    textSize(tth);
    textAlign(CENTER, TOP);
    text(title, x - (radius/2) - xthd + (radius + tw + xthd + 2 *xthd)/2,yth + radius/2 + 5 * 6 );
    
    float sinh = yth + radius/2 + 5 * 4;
    sinus(x - (radius/2) - xthd,sinh, radius + tw + xthd + 2 *xthd, 5, -400, 0);
    sinus(x - (radius/2) - xthd,sinh + tsth*8 + 5 * 4, radius + tw + xthd + 2 *xthd, 5, 400, 0);
    
    sinh = sinh + tsth*8 + 5 * 6;
    
    float cx = radius + tw + xthd + 2 *xthd;
    float lx = cx - 200;
    lx = x - (radius/2) - xthd -20;
    float rx = radius + tw + xthd + 2 *xthd + 20*2;
    //rx = lx + 
    
    textAlign(CENTER, TOP);
    textSize(tdh);
    //rect(lx, sinh, rx,sinh + 200 );
    text(desc, lx, sinh, rx,sinh + 200 ); 
  }
}

void sinus(float x, float y,float w, float amp, float speed, color c){
  float p = (millis() % speed * (2*PI)/speed);
  for(int i=0;i<255;i++){
    float lx = i *(w/255);
    float rx = (i+1) *(w/255);
    
    float ly = sin(lx+p) * amp;
    float ry = sin(rx+p) * amp;
    
    line(x + lx, y + ly,x + rx, y + ry );
  }
}

// to use arc - https://processing.org/reference/PI.html
// use that https://processing.org/tutorials/text/