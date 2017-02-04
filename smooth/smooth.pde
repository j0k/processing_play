ValueSmoother sm;
void setup(){
  sm = new ValueSmoother(0, 100, 0, 300, 5);
}

float lastT = millis(), dt = 300;

void draw(){
  if ((millis() - lastT) > dt)
  {
    lastT = millis();
    sm.addV(A);
    sm.getVUp();
    sm.printIt();
  }
  
  
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
    sm.changeStartEndV(0,100,0,100);
    print("b");
  } else
  if (key == 'd') {
    sm.changeStartEndV(0,100,0,300);
    print("d");
  } 
}