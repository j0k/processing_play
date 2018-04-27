class Manip extends Circle implements IDraw, IDragged, IUp{
   boolean dragged = false;
   Manip(float x, float y, float rad){
     super(x,y,rad);
   }     
   
   void draw(){
     if (dragged){
       fill(100);
     }
     else fill(0);
     ellipse(x,y,rad,rad);
   }
   
   boolean mouseInside(){
     return dist(mouseX,mouseY,x,y) <= rad;
   }
   
   void up(Timing time){
     if (mousePressed &&  mouseInside()){
       dragged = true;
     }
      
      if (dragged){
       x = mouseX;
       y = mouseY;
      }
   }
}