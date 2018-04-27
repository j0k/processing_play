int frames = 380;
float diam = 200, theta;

//float d1 = diam/2; // black 
//float d2 = diam/2; // white

LerpParam dW = new LerpParam(diam/2,0.1);
LerpParam dB = new LerpParam(diam/2,0.1);

 
Manip manip;
PsyDyn gmetrics;

Timing time = new Timing();
void setup(){
  size(600,600);
  gmetrics = new PsyDyn(PSY.BASIC);  
  manip = new Manip(width/6, height/6, 50);
  

  gmetrics.up_att(20);
  gmetrics.up_med(20);
  
  smooth(8);
  noStroke();

  
  setupIndicators();
}

void draw(){
  time.up_time(millis());
  mouseCheck();
  
  float x = random(1) * width;
  float y = random(1) * height;
  fill(color(255,255,255,10));
  //background(255,10);
  rect(0,0,width,height);
  fill(random(255), random(255), random(255));
  //rect(x,y,50,50);
  
  drawJan();
  indicatorsUp(gmetrics);
  manip.draw();
  
  
  drawIndicators();
}


void drawJan() {
  //background(#35465c);
  pushMatrix();
  translate(width/2, height/2);
  rotate(theta);
  
  
  // d1 + d2 = diam
    
  // big circles
  
  
  
  float vd1 = gmetrics.get_att();
  float vd2 = gmetrics.get_med();
  float vdS = vd1 + vd2 + 4;
  vd1 = 200 * (vd1+2)/vdS;
  vd2 = 200 * (vd2+2)/vdS;
  
  dB.ve = vd1;
  dW.ve = vd2;
  
  dB.up(time);
  dW.up(time);
  
  
  //d1 = lerp(d1,vd1,0.1);
  //d2 = lerp(d2,vd2,0.1);
    
  float Cb = -dB.vl/2;
  float Cw = dW.vl/2;
  Cw = diam/2  - abs(Cb);
  
  // norm
  float CbA = abs(Cb) - abs(Cw);
  Cb += CbA;
  Cw += CbA;
  
  // large
  fill(0);
  arc(0,0,diam, diam, PI/2,PI+PI/2);
  fill(255);
  arc(0,0,diam, diam, PI+PI/2,TWO_PI+PI/2);
  
  
  fill(0);
  ellipse(0, Cb, dB.vl, dB.vl);
  fill(255);
  ellipse(0, Cw, dW.vl, dW.vl);
  
  // small circles
  float dWs, dBs;
  dWs = dB.vl/4;
  dBs = dB.vl/4;
  
  if (dWs + dW.vl > diam)
    dWs = diam - dW.vl;
  
  if (dBs + dB.vl > diam)
    dBs = diam - dB.vl;
  
  fill(255);
  
  ellipse(0,Cb, dWs, dWs);
  fill(0);
  //ellipse(0,d1/2, d1/4, d1/4);
  ellipse(0,Cw, dBs, dBs);
  
  popMatrix();
  
  theta += TWO_PI/frames;
  
  //if (frameCount<=frames) saveFrame("image-###.gif");
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == UP) {
      dB.ve ++;
      dW.ve --;
    } else if (keyCode == DOWN) {
      dB.ve --;
      dW.ve ++;
    }
     else if (keyCode == LEFT) {
      //d2 --;
    } else if (keyCode == RIGHT) {
      //d2 ++;
    }
  }
  
  println("d1 = " + dB.vl + " ; d2 = " + dW.vl );
}

void mouseReleased(){  
  manip.dragged = false;
}




void mouseCheck(){
  manip.up(time);
  
  gmetrics.up_att(manip.x * 100 / width);
  gmetrics.up_med(manip.y * 100 / height);    
}