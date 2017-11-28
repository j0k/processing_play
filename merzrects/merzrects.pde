ArrayList<LiquedRect> lrect = new ArrayList<LiquedRect>();

void setup(){
 size(1200,1200);
 
 for(int i =0;i<lrect.size();i++){
   lrect.add( new LiquedRect(200.0 + i*100,200.0,100.0,600.0,50,true,true));
 }
 
}

void draw(){
  background(255);
  for(int i =0;i<lrect.size();i++){
    lrect.get(i).update();
    lrect.get(i).draw();
  }
  //println("sp" + lrect.speed);
  //println("d" + lrect.d);
}

void keyPressed(){
  for(int i =0;i<lrect.size();i++){
    LiquedRect r = lrect.get(i);
    if (!r.mouseIn()) 
      continue;
      
    if (key == CODED) {
      if (keyCode == UP) {
        r.speed  -= 0.1;
      } else if (keyCode == DOWN) {
        r.speed  += 0.1;
      }
      r.genRects();
    }
  }
}