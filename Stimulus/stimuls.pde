  class Stimul extends Circle implements IDraw{
    int ID = 0;
    int time = 0;
    int duration = 0;
    Stimul(int duration, int ID, int time){
      super(0,0,0);
      this.duration = duration;
      this.ID = ID;
      this.time = time;
    }
  
   void drawStimul(){
   }
   void draw(){
      if (millis() - time < duration){
        drawStimul();       
      }
   }
   
   void reset_time(int time){
     this.time = time;
   }
  }
  
  class stimCircle extends Stimul{
    color c;
    stimCircle(float x, float y, float rad, color c, int duration ){
      super(duration, timer.newID(), millis());
      setXY(new Point2D(x,y));
      this.rad = rad;
      this.c = c;    
    }
    
    
    void drawStimul(){
      fill(c);
      ellipse(x,y,rad,rad);
    }
  }