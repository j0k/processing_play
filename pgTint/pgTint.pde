PGraphics pg;

PImage img, imgG;
void setup(){
  size(600,600);
  //pg = new PGraphics();
  img = loadImage("sample.jpg");
  imgG = loadImage("sampleG.jpg");
  pg = createGraphics(width, height);
  
}

boolean loaded = false;
int l = 0;
int r = 255;

PImage transp;
void tinting(){
  
  if (img != null && pg != null){
    
    pg.beginDraw();
    pg.background(0);
    pg.tint(l, 0, l, r);
    pg.image(img,0,0,width,height);
    pg.filter(GRAY,l);
    pg.endDraw();
    transp = pg.get();
    loaded = true;
  }
}

void draw(){
  
  tinting();
   background(0);
   //image(img,0,0,width,height);
   //image(pg, 0, 0);
   image(transp,width>>1,0);
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == UP) {
      l ++;
    } else if (keyCode == DOWN) {
      l --;
    }
     else if (keyCode == LEFT) {
      r --;
    } else if (keyCode == RIGHT) {
      r ++;
    }
  }
  l = bound(l,0,255);
  r = bound(r,0,255);
  
  println("l = " + l + " ; r = " +r );
}

int bound(int v, int l, int r){
  if (v <= l)
    return l;
  
  if (v >= r)
    return r;
   
  return v;
}