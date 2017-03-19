void drawSettings(){
  int x = width - 110;
  int h = 20;
  int rad = 15;
  
  stroke(255);
  
  pushMatrix();
  translate(x, h);
  ellipse(50,10,rad,rad);
  ellipse(30,0,rad*0.7,rad*0.7);
  ellipse(70,0,rad*0.7,rad*0.7);
  //ellipse(60,0,rad*0.7,rad*0.7);
  
  //ellipse(56, 46, 55, 55);
  popMatrix();
}

void drawUI(){
  drawSettings();
}