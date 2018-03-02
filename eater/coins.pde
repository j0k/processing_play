class Coin{
  float x,y,r=10;
  
  float ds = 0.1;
  boolean b = true;
  float balance = 100;
  
  float rm, rM;
  Coin(float x, float y, float r, float ds){
    this.x  =  x;
    this.y  =  y;
    this.r  =  r;
    this.rm =  r/1/3;
    this.rM =  r*2;
    this.ds =  ds;    
  }
  
  void draw(){
    pushMatrix();
    translate(width/2,height/2);
    
    translate(x,y);
    fill(color(255,255,20));   
    ellipseMode(CENTER);
    ellipse(0,0,r,r);
    popMatrix();
  }
  
  void update(){
    if (r>=rM)
      ds = -ds;
    
    if (r<=rm)
      ds = -ds;
    
    r += ds;
  }
  
  boolean if_eaten(Player p){
    float dx = x - p.x;
    float dy = y - p.y;
    if ((sq(dx) + sq(dy)) <= (sq(r/2 + p.rad/2)))
      return true;
    return false;
  }
  
}