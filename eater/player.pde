class Player{
  float x,y;
  
  float vx,vy,ax=0,ay=0;
  float ang_dir = PI;
  float rad = 20;
  
  float att=0, med=0;
  Player(float x, float y, float vx, float vy){
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    
  }
  
  void draw(){
    pushMatrix();
    translate(width/2,height/2);
    
    float dx = vx * cos(ang_dir) + vy * cos(ang_dir);
    float dy = vx * sin(ang_dir) + vy * sin(ang_dir);
    x += dx;
    y += dy;
    translate(x,y);
    //rotate(ang_dir);
    //translate(vx,vy);
    fill(set_color());
    ellipseMode(CENTER);
    to_activate();
    print(dws);
    strokeWeight(dws);
    stroke(255);
    ellipse(0,0,rad,rad);
    popMatrix();
  }
  
  void update_choords(float att, float med){
      this.att = att;
      this.med = med;
      ang_dir +=  (att - med)/2000;
      
      if (abs(x)>width/2)
        x = -x;
      if (abs(y)>height/2)
        y = -y;
                 
      
  }
  
  float r=0, g=0, b=0, dc = 0.1, db = 1;
  color set_color(){
    if (att>med){
      r = lerp(r,100 + map((att-med),0,100,0,150),dc);
      g = lerp(g,map((med),0,100,0,150),dc/10);
    }
    else {
      g = lerp(g,100 + map((med-att),0,100,0,150),dc);
      r = lerp(r,map(att,0,100,0,150),dc/10);
    }
    if (b >= 255)
      db = -abs(db);
    if (b<=0)
      db = abs(db);
    b += db;
    
    return color(r,g,b);
  }
  
  float ws, min_ws=1, max_ws=3, dws=0.1;
  void to_activate(){
    ws += dws;
    
    if (ws >= max_ws)
        dws = -(abs(dws));
       
    if (ws < min_ws){
        dws = 0;
        ws = 1;
    }
    
  }
  
  void touch(){
    dws = 0.1;
    //ws += dws;
  }
}