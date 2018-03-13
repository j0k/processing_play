class Particle{
  float y, angle, dy, da, rad;
  
  Particle(float y, float angle, float da, float rad){
    this.y = y;
    this.angle = angle;
    this.dy = 0;
    this.da = da;
    this.rad = rad;
  }
  
  void draw(){
    pushMatrix();
    translate(width/2, height/2);
    rotate(angle);
    fill(255);
    ellipse(0,y,rad,rad);
    popMatrix();
  }
  
  void update(){
    angle += da;    
  }
}