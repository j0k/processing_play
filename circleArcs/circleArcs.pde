int n = 15;

class ArcCircle{
  float rad;
  float ang0;
  float angD;
  int dir=-1;
}

ArrayList<ArcCircle> A = new ArrayList<ArcCircle>();

void setup(){
  size(1000,800);
  background(255);
  for(int i = 0 ; i< n; i++){
    ArcCircle c = new ArcCircle(); 
    c.rad = 10 + i * 30;
    c.ang0 = random(PI * 2);
    c.angD = (0.1 + random(1)) * HALF_PI;
    if (random(2) > 1)
      c.dir = 1;
    A.add(c);
  }
  
  
  
}


void draw(){
  pushMatrix();
  translate(width/2, height/2);
  background(255);
  fill(255);
  noFill();
  ArcCircle c;// = new ArcCircle();
  for(int i=0; i<n;i++){
    c = A.get(i);
    strokeWeight(1);
    ellipse(0,0,c.rad, c.rad);
    strokeWeight(6);
    arc(0,0,c.rad,c.rad, c.ang0, c.ang0+c.angD);
    c.ang0 %= PI * 2;
  }
  
  for(int i=0; i<n;i++){
    c = A.get(i);
    if (c.rad > height)
      c.rad = 10;
    c.rad += 1.5;
    c.ang0 += c.dir * 0.01;
  }
  
  popMatrix();
}
