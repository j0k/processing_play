/* OpenProcessing Tweak of *@* http://www.openprocessing.org/sketch/17163 *@* */
/* !do not delete the line above, required for linking your tweak if you upload again */

int topPhys = 0;
int physHeight = 0;

class particle{
  PVector x;
  PVector v;
  PVector f;
  particle(){
    x = new PVector(random(0,width),random(topPhys,height));
    v = new PVector();
    f = new PVector();
  }
  void update(){
    v.add(f);
    f = new PVector(0,0.02);
    x.add(v);
  }
}

ArrayList particles;
float diam = 15;
float suck = 1.30;  
float k = 0.2;
float c = 0.01;

ValueSmoother smM,smA;
float lastT = millis(),lastTS = millis(), dt = 100;

void setup(){
  size(400,700);
  topPhys = (int) (height * 0.1);
  physHeight = (int)( height * 0.85);
  fill(0,64);
  noStroke();
  particles = new ArrayList();
  for(int i=0;i<300;i++){
    particles.add(new particle());
  }
  initCodeGenerator();
  vaseBoundSetup();
  initProgressBars();
  smA = new ValueSmoother(0, 100, 0, 100, 20, dt);
  smM = new ValueSmoother(0, 100, 0, 100, 20, dt);
}

float M=50,A=50;
float dtSpeedGen = 20;
void draw(){
  if ((millis() - lastT) > dt)
  {
    lastT = millis();
    smA.addV(A);
    smA.getV();
    
    smM.addV(M);
    smM.getV();
    
  }
  
  smA.getV();
  smM.getV();
  ///level = smA.realV;
  
  levelVase = map(smA.realV,0,100,0,1);
  println(dtSpeedGen);
  dtSpeedGen = 1000 - sq(map(smM.realV,0,100,0,31)) ;
  pushParticle.setDuration( dtSpeedGen);
  
  //if(frameCount%30==0){println(frameRate);}
//  background(0);
  rect(0,0,width,height);
  for(int i=1;i<particles.size();i++){
    particle A = (particle) particles.get(i);
    for(int j=0;j<i;j++){
      particle B = (particle) particles.get(j);
      PVector dx = PVector.sub(B.x,A.x);
      if(abs(dx.x)<diam*suck){
        if(abs(dx.y)<diam*suck){
          if(dx.mag()<diam*suck){
            float restore = (diam - dx.mag())*k;
            dx.normalize();
            float dampen = dx.dot(PVector.sub(B.v,A.v))*c;
            dx.mult(restore - dampen);
            A.f.sub(dx);
            B.f.add(dx);
          }
        }
      }
    }
  }
  if(mousePressed){
      println("x:"+mouseX + " y:"+mouseY);
    }
    
  for(int i=0;i<particles.size();i++){
    particle A = (particle) particles.get(i);
    PVector mouseV = new PVector(mouseX,mouseY);
    PVector pmouseV = new PVector(pmouseX,pmouseY);
    if(mousePressed){
      PVector dx = PVector.sub(A.x,mouseV);
      float pushrad = 80;
      if(abs(dx.x)<pushrad){
        if(abs(dx.y)<pushrad){
          if(dx.mag()<pushrad){
            dx.normalize();
            A.f.add(PVector.mult(dx,0.8));
            A.v.add(PVector.mult(PVector.sub(
              PVector.sub(mouseV,pmouseV),A.v),0.2));
          }
        }
      }
     
    }
    
    boolean dampen = false;
    if(A.x.x<0){
      A.f.x -= A.x.x*k;
      dampen = true;
    };
    if(A.x.x>width){
      A.f.x -= (A.x.x-width)*k;
      dampen = true;
    };
    if(A.x.y<topPhys){
      A.f.y -= -(topPhys - A.x.y)*k;
      dampen = true;
    };
    
    int physHeight = (int)( height * 0.85);
    if(A.x.y>physHeight){
      A.f.y -= (A.x.y-physHeight)*k;
      dampen = true;
    };
    
    // contact of A with bounds
    if (checkContact(A))
      dampen = true;
    
    
    if(dampen){A.v.mult(0.9);}
    A.update();
    set(int(A.x.x),int(A.x.y),color(255));
  }
  
  for (int i=0;i<LeftBoundX.length;i+=2){
    //set(LeftBoundX[i]/2,i/2,126);
  }
  code_draw();
  stroke(255);
  color(255);
  
  int simline = 170;
  int pad = 170;
  for (int i = 1; i < artVase.length; i++){
    PVector pre = toPVector(artVase[i-1]);
    PVector last = toPVector(artVase[i]);
    //line(pre.x,pre.y,last.x,last.y);
    //line(simX((int) pre.x,simline,pad),pre.y, simX((int)last.x,simline,pad),last.y);
    
  }
  
  for (int i = 1; i < artVase.length; i++){
    PVector pre = toPVector(artVase[i-1]);
    PVector last = toPVector(artVase[i]);
    //println("line("+simX((int) pre.x,simline,pad)+","+pre.y+"," + simX((int)last.x,simline,pad)+","+last.y+");");   
    //line(simX((int) pre.x,simline,pad),pre.y, simX((int)last.x,simline,pad),last.y);
    
  }
  drawAllBounds();
  pushParticles();
  
  drawSettings();
  updateProgressBars();
}

boolean stopAll = false;
void mouseReleased(){
  if (!stopAll)
  stopAll = true;
  else 
  stopAll = false;
  //code_onMouseReleased();
  

}


void keyReleased()
{
  if (key == CODED) {
    if (keyCode == UP) {
      A = setVal(A,10,100);
    } else if (keyCode == DOWN) {
      A = setVal(A,-10,0);
    } else if (keyCode == LEFT) {
      M = setVal(M,-10,0);
    } else if (keyCode == RIGHT) {
      M = setVal(M,10,100);
    }
    print ("A:"+A + " M:"+M + "\n");
  }
  
  if (key == 'b') {
    smA.changeStartEndV(0,100,0,10);
    print("b");
  } else
  if (key == 'd') {
    smA.changeStartEndV(40,100,0,300);
    print("d");
    coords.clear();
  } 
}