int NP = 20;

Particle[] parts;

void setup(){
  size(600,600);
  parts = new Particle[NP];
  for(int i =0;i<parts.length; i++)
    parts[i] = new Particle(100 + random(100), random(2*PI), 0.005 + random(0.01), 20);
}

void draw(){
  background(0);
  
  for(Particle p : parts){
    p.update();
    p.draw();
  }
  
  
}