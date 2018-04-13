// triangle which will be circle or rect

Manip manip;
PsyDyn gmetrics;
PSYExp player;
void setup(){
  size(600,600);
  
  gmetrics = new PsyDyn(PSY.BASIC);
  player = new PSYExp();
  manip = new Manip(width/2, height/2, 50);
  
  setupIndicators();
  sceneSetup();
  setupTasks();
  
}

Timing time = new Timing();
void draw(){
  time.up_time(millis());
  background(240);

  
  mouseCheck();
  
  
  indicatorsUp(gmetrics);
  drawIndicators();
  drawScene();
  SM.up(time);
  SM.up_psy(gmetrics);
  
  taskUpdate();
  if (timer.on_timer(0,1000)){
    //println(SM.print_status());
    println(player.str());
    float[] lpv = to_LPV(player.exp[2]);
    println(LPV_str(lpv));
  }
  manip.draw();
}


void mouseCheck(){
  manip.up(time);
  
  gmetrics.up_att(manip.x * 100 / width);
  gmetrics.up_med(manip.y * 100 / height);    
}

void mouseReleased(){  
  manip.dragged = false;
}