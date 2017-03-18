ValueSmoother sm;
void setup(){
  sm = new ValueSmoother(0, 100, 0, 300, 100, dt);
  
  size(800,400);
}

float lastT = millis(),lastTS = millis(), dt = 3;

int x = 0;
color c1,c2,c3;
void draw(){
  if ((millis() - lastT) > dt)
  {
    lastT = millis();
    sm.addV(A);
    sm.getV();
    
    c1 = color(150+random(100), 150+random(100), 150+random(100));
    c2 = color(random(100), random(100), random(100));
    
    print("\n");
    //sm.printIt();
  }
  
  if ((millis() - lastTS) > 1000)
  {
    lastTS = millis();
    c3 = color(200+random(50), 200+random(50), 200+random(50));
  }
  sm.getV();
  sm.printIt();
  
  
  
  stroke(c3);
  line(x, 10+sm.realV -30, x, 10+sm.realV + 30);
  stroke(c1);
  line(x, 10+sm.realV -10, x, 10+sm.realV + 10);
  stroke(c2);
  point(x, 10+sm.realV);
  x ++;
  if (x>width) x = 0;
  
}

float M=50,A=50;
float rM, rA;

void keyReleased()
{
  if (key == CODED) {
    if (keyCode == UP) {
      A = setVal(A,10,100);
    } else if (keyCode == DOWN) {
      A = setVal(A,-10,0);
    } else if (keyCode == LEFT) {
      M = setVal(M,-10,0);
    } else if (keyCode == RIGHT) {
      M = setVal(M,10,100);
    }
    print ("A:"+A + " M:"+M + "\n");
  }
  
  if (key == 'b') {
    sm.changeStartEndV(0,100,0,10);
    print("b");
  } else
  if (key == 'd') {
    sm.changeStartEndV(40,100,0,300);
    print("d");
  } 
}