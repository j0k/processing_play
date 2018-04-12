// https://pdfs.semanticscholar.org/2a43/51e0e414325fe4abb747a2affd4d03408465.pdf

// page: 121 (Chapter: Creativity)

float letterSpace = 30;
float rx() { return(random(letterSpace + 10)); }
float ry() { return(random(height - 10)); }
int rWordlen() { return(3 + int(random(4))); }

void setup(){
  size(500,100);
}

void draw() {
  if (mousePressed)
    return;
  background(255);
  stroke(0);
  int letters = (int) (width / letterSpace) - 4;
  int wordLen = rWordlen();
  int word = 0;
  float x = rx(); float y = ry();
  for (int letter = 0; letter < letters; ++letter) {
    float ox = letter * letterSpace + word * letterSpace;
    if (wordLen -- == 0) {
      wordLen = rWordlen();
      word++;
      }
    for (int i = 0; i < 3; ++i) {
      float x1 = rx() + ox; float y1 = ry();
      bezier(x, y, rx() + ox, ry(),
      rx() + ox, ry(), x1, y1);
      x = x1; y = y1;
    }
  }
}