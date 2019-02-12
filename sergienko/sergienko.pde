class Romashka{
  float x,y;
  float radX,radY;
  
  float c0=0.0, c0u, r0 =0.1, n;
  Romashka(float x, float y, float radX, float radY, int n, float c0u){
    this.x = x;
    this.y = y;
    this.radX = radX;
    this.radY = radY;
    this.n = n;
    this.c0u = c0u;
  }
  

  void render(PGraphics land){
    land.beginDraw();
    c0 += c0u;
    for(int i=0;i<n;i++){
      land.pushMatrix();
      land.translate(x, y);
      land.rotate(c0 + i * 1.0 * 2 * PI / n);
      land.noStroke();
      land.fill(255);
      land.ellipse(0,0,radX,radY);
      land.popMatrix();
    }
    
    land.pushMatrix();
    land.translate(x,y);
    land.fill(240,240,0);
    r0 += 0.01;
    land.ellipse(0,0,radX/3+sin(r0)*40,radX/3+sin(r0)*40);
    land.popMatrix();
    
    land.endDraw();
  }
}

ArrayList<Romashka> r; 
PGraphics alphaG;
 

void setup(){
  //size(1280*2,220*2);
  size(1000,1000);
  setup_rom();
  alphaG = createGraphics(width,height, JAVA2D);
}

void setup_rom(){
  r = new ArrayList<Romashka>();
  
  for(int i=0;i<16;i++){
    float s = 60+random(200);
    r.add(new Romashka(random(width), random(height), s, s/5, 12, -0.003 + random(0.006)));  
  }
}

void draw(){
  alphaG.beginDraw();
  alphaG.fill(30,40,255);
  alphaG.rect(0,0,width,height);
  alphaG.endDraw();
  //background(30,40,255);
  

  for(int i=0;i<r.size();i++){
    r.get(i).render(alphaG);
  }
  
    
  
  image(alphaG, 0,0);
  
  save_it(alphaG);
  alphaG.clear();
}

int frame_i = 0;
void save_it(PGraphics land){
  if (saving){
    String fn = "blue2\\land_" + nf(frame_i,5,0) + ".png";
    land.save(fn);
    frame_i ++;
    println(fn);
  }
}

void mouseReleased(){
  setup_rom();
}

boolean saving = false;
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP){
      saving = true;
    } else if (keyCode == DOWN){
      saving = false;
    }
  }
}
