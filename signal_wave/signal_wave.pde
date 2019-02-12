PGraphics alphaG;

void setup() {
  size(1000,700);
  
  stroke(255);
  strokeWeight(1);
  smooth();
  
  noCursor();
  alphaG = createGraphics(width,height, JAVA2D);
}

float v = 0;
float w = 0;

void draw() {
  alphaG.beginDraw();
  alphaG.noStroke();
  alphaG.fill(255,50);
  alphaG.rect(0,0,width,height);
  
  alphaG.stroke(1);
  alphaG.strokeWeight(10);
  alphaG.noFill();
  alphaG.beginShape();
  for(float x = 0; x < width; x += 1) {
    float yn = height/2+mouseY
    *sin(v+(x/map(mouseX,0,width,1,100)))
    *tan(w+(x/map(mouseY,0,width,100,400)))
    *sin(v+(x/map(mouseY,0,height,1,100)));
    
    //if (yn<height/20)
    //  yn = height/20;
    alphaG.vertex(x, yn);
    
  }
  alphaG.endShape();
  v -= 0.02;
  w += 0.01;
  
  alphaG.endDraw();
  image(alphaG, 0,0);
  
  save_it(alphaG);
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

int frame_i = 0;
void save_it(PGraphics land){
  if (saving){
    String fn = "save_2\\land_" + nf(frame_i,5,0) + ".png";
    land.save(fn);
    frame_i ++;
    println(fn);
  }
}
