// https://www.openprocessing.org/sketch/396923

// arc, PI, strokeCap, revolve, ellipse
// An animation of a still graphic I saw on-line somewhere.
// Click to toggle background black/white

float move;
boolean isBlkbg;

void setup() {
  size(600, 600);
  noFill();
  strokeCap(SQUARE);
  isBlkbg = true;
}

void draw() {
  if (isBlkbg) background(50);
  else background(245);
  drawShape(500, move);
  drawShape(450, move*.6);
  drawShape(400, move*.9);
  drawShape(350, move*1.5);
  move += .01;
}

void drawShape(float sze, float incr) {
  if (isBlkbg) stroke(245, 100);
  else stroke(50, 50);
  strokeWeight(.5);
  ellipse(width/2, height/2, sze, sze);
  if (isBlkbg)stroke(245);
  else stroke(50);
  strokeWeight(3);
  arc(width/2, height/2, sze, sze, incr, incr+ PI);
  strokeWeight(15);
  arc(width/2, height/2, sze, sze, -incr, -incr+PI/2.0);
  strokeWeight(25);
  arc(width/2, height/2, sze, sze, incr/2, incr/2+PI/6);
}

void mousePressed() {
  isBlkbg = !isBlkbg;
}
