int DT = 3 * 1000;
float P_USUAL = 0.5;

ArrayList<Stimul> stimuls = new ArrayList<Stimul>(2);
void setup(){
  size(500,500);
  stimuls.add(new stimCircle(width/2, height/2, min(width,height)/3.0, color(0,255,0), 500));
  stimuls.add(new stimCircle(width/2, height/2, min(width,height)/3.0, color(255,0,0), 500));
}

int t = (random(1)<0.8)?1:0;
void draw(){
  background(0);
  stimuls.get(t).draw();
  if (timer.on_timer(0, DT)){
    float p = random(1);
    t = (p < P_USUAL) ? 0:1;
    stimuls.get(t).reset_time(millis());
    print(p);
  }
}