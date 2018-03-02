// source for scroll
// https://processing.org/examples/scrollbar.html

HScrollbar hsAtt, hsMed, hsState;  // Two scrollbars

class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  String title;
  float value, rvalue;  

  HScrollbar (float xp, float yp, int sw, int sh, int l, String title, float defvalue) {
    this.title = title
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
    value2pos(defvalue);
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
    
    rvalue  = map(newspos, sposMin, sposMax, 0.0, 100.0);
    value   = map(spos, sposMin, sposMax, 0.0, 100.0);
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
        
    
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
    
    fill(0);
    text(title + ": " + nf(value, 3,2), xpos + 5, ypos + sheight -2);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }

  float value2pos(float val){
    if (val > 100)
      val = 100;
    else if (val < 0)
      val = 0;
    rvalue = val;
    newspos = map(rvalue, 0.0, 100.0, sposMin, sposMax);    
    return rvalue
  }

  float dvalue2pos(float val){
    return value2pos(rvalue + val);
  }
}


void keyPressedScrolls() {  
  if (key == CODED) {
    if (keyCode == UP) {
      hsAtt.dvalue2pos(+ 10);
    }
    else if (keyCode == DOWN) {
      hsAtt.dvalue2pos(- 10);
    }
    else if (keyCode == RIGHT) {
      hsMed.dvalue2pos(+ 10);
    }
    else if (keyCode == LEFT) {
      hsMed.dvalue2pos(- 10);
    }
  } 
}