import java.util.Collections;
ArrayList<PVector> coords;

void initCodeGenerator(){
  coords = new ArrayList<PVector>();
}

void code_onMouseReleased(){
  // mouseReleased
  coords.add(new PVector(mouseX,mouseY));
  stroke(255);
  int s = coords.size();
  if (s >= 2){
    PVector pre = coords.get(s-2);
    PVector last = coords.get(s-1);
    println("line("+pre.x+","+pre.y+"," + last.x+","+last.y+");");
    line(pre.x,pre.y,last.x,last.y);
  
  }
}

void code_draw(){
  int s = coords.size();
  if (s>=2){
    for (int i = 1; i < s; i++ ){
      PVector pre = coords.get(i-1);
      PVector last = coords.get(i);
      line(pre.x,pre.y,last.x,last.y);
    }
  }
  
}

PVector toPVector(int[] a){
   return new PVector(a[0],a[1]);
}