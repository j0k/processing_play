import java.util.Collections;
import java.util.List;
import java.util.ArrayList;


int NE = 10;

int MAX_R = 500, MIN_R = 100;

ArrayList<LCircle> rs = new ArrayList<LCircle>();

class LCircle{
  int r;
  
  LCircle(int r){
    this.r = r;
  }
  
  void draw(){
    ellipseMode(CENTER);
    pushMatrix();
    translate(width/2, height/2);
    ellipse(0,0,r,r);
    popMatrix();
  }
  
  void grow(){
    r ++;
  }
  
  void up(){
    grow();
    if (r > MAX_R){
      r = MIN_R;
    }
  }
}


void setup(){
  size(600,600);
  
  for(int i = 0;i<NE; i++){
    rs.add(new LCircle((NE+2) * 30 - i * 30));  
  }
  
  strokeWeight(5);
  stroke(255);
  fill(0);
}

void draw(){
  Collections.sort((List<LCircle>)rs, new CustomComparator());
  
  for (int i = 0; i< rs.size(); i++){
    rs.get(i).draw();   
  }
  
  for(LCircle c : rs){
    c.up();
  }
}