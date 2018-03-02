// TASK1: by press button - it need to go stabilize going by ellipse track 


int N = 200;

class Particle{
  float x, y;
  float vx, vy;
  float ax, ay;
  
  float th = 1;
  float r  = 5;
  
  Particle(float x, float y, float vx, float vy){
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.ax = 0;
    this.ay = 0;
  }
  
  void draw(){
    fill(255);
    strokeWeight(th);
    ellipse(x,y,r+th,r+th);
  }
  
  void update(){
    vx += ax;
    vy += ay;
    x  += vx;
    y  += vy;
    
    if (abs(x) > width)
      x = abs(x) % width;
      
    if (abs(y) > height)
      y = abs(y) % height;
  }
}

Particle[] ps;
void setup(){
  size(500,500);
  ps = new Particle[N];
  
  for (int i=0; i<N; i++){
    ps[i] = new Particle(random(width), random(height), -0.5 + random(5)/6, -0.5 + random(5)/6);
  }
}

void draw(){
  for(Particle p : ps){
    p.update();
    p.draw();
  }
}