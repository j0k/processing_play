float x1,x2,y1,y2;

int n=200;
float a=20;
float c0 = PI;
float c1 = 0.1;
float rotG = 0;
float t1;
void setup(){
  size(1000,1000);
  
  x1=200;y1=300;
  x2=600;y2=300;
  
  x1=0;y1=0;
  x2=400;y2=0;
  
  background(0);
  t1 = millis();
  pushMatrix();
  translate(400, 300);
}

void draw(){
  pushMatrix();
  translate(width/2, height/2);
  c0 += 0.1;
  background(0);
  fill(255);
  stroke(255);
  
  
  
  float ang = 0;
  float angG = cos((float)millis()/1000)/10;
  if (millis() - t1> 1000){
    rotG += 1;
    rotG %= 24;
    t1 = millis();
  }
  
  pushMatrix();
  rotate(rotG * 2.0 * PI / 24);
  //line(x1,y1,x2,y2);
  for(int i =0;i<n;i++){
    pushMatrix();
    ang = (angG/n) * i;
    rotate(ang);
    float px1,px2,py1,py2;
    px1 = x1 + (x2-x1)/n * i;
    px2 = x1 + (x2-x1)/n * (i+1);
    float a0 = a * abs(n/1.5 - abs(i - n/1.5))/(n/2); 
    py1 = y1 + a0 * cos(c0 + (x2-x1)/n * i * c1);
    py2 = y2 + a0 * cos(c0 + (x2-x1)/n * (i+1) * c1);
    
    line(px1, py1, px2, py2);
    popMatrix();
  }
 popMatrix();
 popMatrix();
}
