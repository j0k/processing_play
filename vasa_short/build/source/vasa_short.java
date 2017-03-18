import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Collections; 
import java.util.Comparator; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class vasa_short extends PApplet {




PImage img, imgLF, imgRF, imgWhite;
int ybase = 55;

float A = 50, M = 50;

Smoother attSm = new Smoother(), medSm = new Smoother();
//SmootherTimer arcsAdding;

ImagePlastic vasa, leftFace, rightFace, vasaWhite;
StageController stage;
EEGEmulator eeg = new EEGEmulator();
ScreenNotification notify = new ScreenNotification();


public void setup(){
  
  noFill();

  stage = new StageController();
  img = loadImage("tusion_logo.png");
  imgWhite = loadImage("tusion_logo_white.png");
  imgLF = loadImage("leftFace.png");
  imgRF = loadImage("rightFace.png");

  vasa = new ImagePlastic(img,img_x,img_y,img_width,img_height,100);
  leftFace = new ImagePlastic(imgLF,img_x,img_y,img_width,img_height,200);
  rightFace = new ImagePlastic(imgRF,img_x,img_y,img_width,img_height,200);

  bounds = new ArrayList<PointBound>();
  //arcsAdding = new SmootherTimer(30, 2, 0, 100, 1); // we need only second param and last param here

  vasaCenX = img_x + img_width/2;
}

int xcen_left=80, xcen_right=140;
int ycen=210;
int vasaCenX;

int img_x=10, img_y=10, img_width=410, img_height=410;

boolean speed_balance = false;
boolean bounds_balance = false;

public void draw(){
  eeg.update(A,M);
  A = eeg.A;
  M = eeg.M;

  attSm.add(A);
  medSm.add(M);

  if (stage.focusVase())
    arcs.addV(A);
  else
    arcs.addV(M);

  background(255);
  int c = color(255, 204, 0);
  color(c);

  stage.draw();
  stage.update();


  //vasa.loop();
  //noTint();
  //image(img, img_x, img_y, img_width, img_height);
  stroke(c);


  //fill(255 - vasa.oppacity);
  noFill();
  for(int i =0; i<bounds.size();i++)
    {
      bounds.get(i).draw();
      bounds.get(i).update();
      if (stage.influenceOppacity)
        bounds.get(i).c = color(vasa.oppacity);
    }

 if (speed_balance){
   start_speed_relax();
 }

 if (bounds_balance){
   start_balance_bounds();
 }

 if (stage.nextLevel(A, M)){
   stage.levelChanged = false;

   print("LEVEL CHANGED ! " + "A:"+A + " M:"+ M + " - " + stage.level + "\n");
   print("FOCUS FACE:" + stage.focusFace()+ " --: FOCUS VASE:" +stage.focusVase()+"\n");
 }
 notify.draw();
}

ArrayList<PointBound> bounds;
float b1=HALF_PI,b2=PI;
float step=0.01f;

public void draw_arc_line(){
  arc(110, ycen, 60, 20, b1, b2);

  if (b1 < PI)
    b1 += step;

  if (b2 < PI)
    b2 += step;

  if (b1 >= PI){
    b1 = 0;
    b2 = HALF_PI;
  }
}




float t=0;
public void mousePressed() {
  println("x = " + mouseX + " ; y = " + mouseY);
  bounds.add(add_arc(vasaCenX, mouseY, abs(vasaCenX-mouseX)*2, abs(vasaCenX-mouseX)*2/3, random(0.10f)));
}

float avg_speed = 0;

public void start_speed_relax(){
  if (avg_speed <= 0.00001f){
  float speed = 0;
   for(int i =0; i<bounds.size();i++)
    {
      speed += bounds.get(i).step;
      //bounds.get(i).update();
    }

    speed = speed / bounds.size();
    print(speed + "-sp-");
    if(speed<0)
      speed = - speed;
    avg_speed = speed;

  }

  for(int i =0; i<bounds.size();i++)
    {
      bounds.get(i).step = to_speed(avg_speed, avg_speed - bounds.get(i).step, 0.00001f);
      //bounds.get(i).update();
    }
}

public float to_speed(float to_speed, float cur_speed, float iter){
  if (abs(cur_speed - to_speed) <= iter)
     return to_speed;

  if (cur_speed > to_speed)
    return cur_speed - iter;
  else
    return cur_speed + iter;
}

public void start_balance_bounds(){

  float b1 = 0;
  float b2 = 0;

  for(int i =0; i<bounds.size();i++)
  {
    b1 += bounds.get(i).b1;
    b2 += bounds.get(i).b2;
  }

  b1 = b1 / bounds.size();
  b2 = b2 / bounds.size();

  for(int i =0; i<bounds.size();i++)
    {
      bounds.get(i).b1 = to_speed(b1, bounds.get(i).b1, 0.01f);
      bounds.get(i).b2 = to_speed(b2, bounds.get(i).b2, 0.01f);
    }
}

public void set_width_stroke(int sw){

  for(int i =0; i<bounds.size();i++)
  {
    bounds.get(i).sw = sw;
  }
}

public float setVal(float p, float add, float def){
  float newVal = p+add;

  if (def<=0){
    if (newVal<def)
      return def;
    else return newVal;
  } else
  if (def>=100)
    if (newVal>=def)
      return def;
    else return newVal;

  return def;
}

public void keyReleased()
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
    AddRandArcs(10,0.02f);
    print("b");
  } else
  if (key == 'd') {
    RemoveRandArcs(5);
    print("d");
  } else
  if (key == 's') {
    speed_balance = true;
  } else
  if (key == 'S') {
    speed_balance = false;
  } else
  if (key == 'a') {
    bounds_balance = true;
  } else
  if (key == 'A') {
    bounds_balance = false;
  } else
  if (key == 'f') {
    set_width_stroke(4);
  } else
  if (key == '1') {
    stage.toStage = 1;
  } else
  if (key == '2') {
    stage.toStage = 2;
  } else
  if (key == '3') {
    stage.toStage = 3;
  } else
  if (key == '4') {
    stage.toStage = 4;
  } else
  if (key == '5') {
    stage.toStage = 5;
  } else
  if (key == '6') {
    stage.toStage = 6;
  }


}

public void exit() {
  println("exiting");
  super.exit();
}
class ActionTimer{
  float lastTime = 0;
  
  float duration = 1000;
  float livetime=0, liveTimeMax = -1, liveTimeStart;

  ActionTimer(float dt){
    this.duration = dt;
    this.lastTime = millis();
    this.liveTimeStart = millis();
  }
  
  ActionTimer(float dt, float liveTimeMax){
    this.duration = dt;
    this.liveTimeMax = liveTimeMax;
    this.lastTime = millis();
    this.liveTimeStart = millis();
  }
  
  public boolean itsDurationEnough(float time){
    if (time - lastTime > duration){
      livetime += (time - lastTime);
      lastTime = time;
      return true;
    } else return false;
  }
  
  public boolean itsDurationEnough(){
    return itsDurationEnough(millis());
  }
  
  public void refresh(){
    this.lastTime = millis();
    
  }
  
  public boolean isOver(){
    if (( liveTimeMax != -1) && ((millis() - liveTimeStart) >liveTimeMax)){
      return true;
    } else return false;
  }
  
  public float toCountOver(float c){
    if ( liveTimeMax != -1){
      if (millis() - liveTimeStart > liveTimeMax){
        return c;
      } else return c * (millis() - liveTimeStart)/ (liveTimeMax);
    }
    return 0;
  }
}
class EEGEmulator{
  ActionTimer t = new ActionTimer(500);
  
  int dV = 6;
  float A=50, M=50;
  
  public void update(){
    float dA = dV/2 - random(dV), dM = dV/2 - random(dV);
    
    if (t.itsDurationEnough()){
      this.A += dA;
      this.M += dM;
    }
  }
  
  public void update(float A, float M){
    this.A = A;
    this.M = M;
    float dA = dV/2 - random(dV), dM = dV/2 - random(dV);
    
    if (t.itsDurationEnough()){
      this.A += dA;
      this.M += dM;
    }
  }
}
// eye info
// http://evaldaz.deviantart.com/art/Eye-in-profile-110035035
class ImagePlastic {
  PImage img;
  float transpPerSec; // 255 per second means that we need 1 sec to appear
  boolean visible = true;
  
  int img_x, img_y, img_width, img_height;
  float oppacity=0;
  float max_oppacity = 255, min_oppacity = 0;
  
  public void draw(){
    tint(255, oppacity);
    if (oppacity!=0)
      image(img, img_x, img_y, img_width, img_height);
  }
  
  boolean updated = false;
  
  boolean firstTimeRun = true;
  public void update(){
    time = millis();
    if (firstTimeRun){
      lastOppacityChangeTime = time;
      firstTimeRun = false;
    }
    
    float dt = time - lastOppacityChangeTime;
    
    //print("\n + a:" + appearing + " disa:" +disappearing + "  " + time + " dt:" +dt + " op:"+ this.oppacity+"\n");
    if (disappearing){
      int opp = setTranspPerSec(dt);
      oppacity = oppacity - opp;
      if (oppacity < min_oppacity){
        oppacity = min_oppacity;
        disappearing = false;
      }
      
      updated = true;
    }
    
    if (appearing){
      //print("Appear" + oppacity + "-" + appearing);
      int opp = setTranspPerSec(dt);
      oppacity = oppacity + opp;
      if (oppacity >= max_oppacity){
        oppacity = max_oppacity;
        appearing = false;
        endAppearing = true;
      }
      
      updated = true;
    }
    
    if (updated){
      updated = false;
    }
    lastOppacityChangeTime = time;
  }
  
  ImagePlastic (PImage img, int x, int y, int w, int h, float tPS){
    this.img = img;
    this.img_x = x;
    this.img_y = y;
    this.img_width = w;
    this.img_height = h;
    this.transpPerSec = tPS;
  }
  
  public int setTranspPerSec(float dtime){
    float opp = (dtime/1000) * transpPerSec;
    return (int) opp;
    // 1000 ms = 1 sec
  }
  
  float lastOppacityChangeTime = 0;
  float time;
  
  boolean appearing = false;
  boolean endAppearing = false;
  
  boolean disappearing = false;
  boolean endDisappearing = false;
  
  public void startAppear(){
    endDisappearing = false;
    appearing = true;
    disappearing = false;
  }
  
  public void startDisapper(){
    endAppearing = false;
    disappearing = true;
    appearing = false;
  }
  
  public void loop(){
    if ((!appearing) && (endAppearing)){
      startDisapper();
    }
    else 
    if ((!disappearing) && (endDisappearing)){
      startAppear();
    } if ((!appearing) && (!disappearing)){
      startAppear();
    } 
  }
  
  public void reverseAppearing(){
    if ((!appearing) && (endAppearing)){
      startDisapper();
    } else startAppear();
  }
}
class ScreenNotification{
  ArrayList<Note> notes = new ArrayList<Note>();

  ArrayList<ActionTimer> timer = new ArrayList<ActionTimer>();

  public void draw(){
    for(int i=0; i < notes.size(); i++){
      fill(timer.get(i).toCountOver(255));
      textSize(25 - timer.get(i).toCountOver(24));
      if (notes.get(i).t == 0)
        text(notes.get(i).msg, notes.get(i).x, 100 - (int) timer.get(i).toCountOver(80) );
      else if (notes.get(i).t == 1)
        text(notes.get(i).msg, notes.get(i).x, 100 + (int) timer.get(i).toCountOver(80) );
    }

    int c = 0;
    int i = 0;
    int s = timer.size();
    while( c < s){
      if (timer.get(i).isOver()){
        timer.remove(i);
        notes.remove(i);
        c ++;
      } else{
        i++;
        c++;
      }
    }
  }

  public void addText(String str){
    addText(str,width/2,0);
  }

  public void addText(String str, int x){
    addText(str,x,0);
  }

  public void addText(String str, int x, int t){
    notes.add(new Note(str,x,t));
    timer.add(new ActionTimer(20,3000));
  }
}

class Note{
  String msg;
  int x;
  int t=0;

  Note(String m, int x){
      this.msg = m;
      this.x = x;
  }

  Note(String m, int x, int t){
      this.msg = m;
      this.x = x;
      this.t = t;
  }
}
class PointBound implements Comparable<PointBound> {
  public float PB_PI = PI - 0.15f;
  public float b1, b2;
  public int w,h,ycen,xcen;
  public int c;
  public int sw=strokeWeight; //strokeWeight
  public float stepdef=0.02f;
  public float step=0.02f;
  
  public void draw(){
    stroke(this.c);
    strokeWeight(sw);
    arc(xcen, ycen, w, h, b1, b2);
  }
  
  public void update(){
    
    if ((b1 < PB_PI) )
      b1 += step;
  
    if (b2 < PB_PI){
      b2 += step;
      
      if((b2-b1) < HALF_PI){
        b2 += step;
      }
    }
  
    if (b1 >= PB_PI){
      b1 = 0;
      b2 = 0;
    }  
    
  }
  
  // compare
  // http://stackoverflow.com/questions/18441846/how-to-sort-an-arraylist-in-java
  @Override
  public int compareTo(final PointBound pb) {    
    if (this.ycen < pb.ycen)
      return 1;
    else 
      return -1;

  }
}

int pbDefColor = color(0,0,0);
boolean colorizing = false;
int strokeWeight = 1;
public PointBound add_arc(int xcen, int ycen, int w, int h, float step){
  
  PointBound pb = new PointBound();
  pb.xcen = xcen;
  pb.ycen = ycen;
  pb.w = w;
  pb.h = h;
  pb.b1 = 0;
  pb.b2 = HALF_PI;
  pb.step = step;
  if (colorizing)
    pb.c = color(round(random(255)), round(random(255)), round(random(255)));
  else
    pb.c = pbDefColor;
  pb.sw = round(1+random(1));
  
  return pb;
}
class Smoother{
  float[] coefs = {0.05f, 0.1f, 0.15f, 0.2f, 0.2f, 0.3f};
  float[] v = new float[6];
  
  Smoother(){
    for(int i=0;i<v.length;i++){
      v[i] = 0;
    }
  }
  
  public float add(float V){
    for(int i=1;i<v.length;i++){
      v[i-1] = v[i];
    }
    v[5] = V;
    return V;
  }
  
  public float getV(){
    float r = 0;
    for(int i=0;i<v.length;i++){
      r += coefs[i]*v[i];
    }
    return r;
  }
}

class ValueSmoother{
  Smoother coords = new Smoother();
  Smoother realVs = new Smoother();
  
  float startV, endV;
  float startRealV, endRealV;
  
  float curV;
  float realV;
  
  float maxRealVPerSec, msPerUp;
  
  ValueSmoother(float startV, float endV, float startRealV, float endRealV, float maxRealVPerSec, float msPerUp){
    this.startRealV = startRealV;
    this.endRealV = endRealV;
    this.startV = startV;
    this.endV = endV;
    this.maxRealVPerSec = maxRealVPerSec;
    this.msPerUp = msPerUp;
  }
  
  public void addV(float v){
    coords.add(v);
  }
  
  float lasttime, lasttime_micro;
  float realVtmp;
  
  boolean active = true;
  public float getV(){
    float r = 0;
    if (active){
      float time = millis() - lasttime;
      if (time >= msPerUp){
        r = getVChanged();
      } else {
        r = getVMicro();
      }
    }
    return r;
  }
  
  public float getVMicro(){
    float time = millis() - lasttime_micro;
    
    if (abs(realVtmp - realV) > maxRealVPerSec * (time/1000)){
      realV = toV(realV, between(realVtmp, startRealV, endRealV), maxRealVPerSec * (time/1000)); //sign(realVtmp) * maxRealVPerSec * (time/1000);
      //println("@@"+realV + "--"+realVtmp+"**"+time);
    } else {
      realV = realVtmp;
    }
    
    lasttime_micro = millis();
    return realV;
  }
    
  public float getVChanged(){
    float time = millis() - lasttime;
    
    curV = coords.getV(); // it's
    curV = between(curV, startV, endV);
    
    float vMap = map(curV, startV, endV, startRealV, endRealV);
  
    realVs.add(vMap);
    
    
    realVtmp = realVs.getV();
    

    lasttime = millis();
    //lasttime_micro = lasttime;
    return realV;
    
  }
  
  public float between(float v,float  vLeft,float vRight){
    if (vLeft <= vRight){
      if (v < vLeft)
      return vLeft;
      else if (v > vRight)
      return vRight;
      else
      return v;
    } else {
      if (v > vLeft)
      return vLeft;
      else if (v < vRight)
      return vRight;
      else return v;
    }
  }
  

  public void changeStartEndV(float startV, float endV, float startRealV, float endRealV){
    this.startV = startV;
    this.endV = endV;
    this.startRealV = startRealV;
    this.endRealV = endRealV;
  }
  
  public void printIt(){
    print("V:"+realV+"\n");
  }
}
class StageController{
  int toStage = 0;
  String stage = "none";
  
  
  boolean defVasa = false;
  boolean defLeftVasaDetails = false;
  boolean defRightVasaDetails = false;
  
  public void draw(){
    //if(defVasa){
        vasa.draw();
        vasa.update();
    //}
    //if(defLeftVasaDetails){
        leftFace.draw();
        leftFace.update();
    //}
    //if(defRightVasaDetails){
        rightFace.draw();
        rightFace.update();
    //}
  }
  
  public void update(){
     balanceArcsC();
    
     switch(toStage){
      case 1:{
        stageAtt1();
        toStage = 0;
        stage  = "vasa";
        break;
      }
      case 2:{
        stageAtt2();
        toStage = 0;
        stage = "vasa";
        break;
      }
      case 3:{
        stageAtt3();
        toStage = 0;
        stage  = "det_Lvasa";
        break;
      }
      case 4:{
        stageAtt4();
        toStage = 0;
        stage = "det_Lvasa";
        break;
      }
      case 5:{
        stageAtt5();
        toStage = 0;
        stage  = "det_Rvasa";
        break;
      }
      case 6:{
        stageAtt6();
        toStage = 0;
        stage = "det_Rvasa";
        break;
      }
      default:return;
    }
    
    if (stage=="vasa"){
      defVasa = true;
    } else
    if (stage=="det_Lvasa"){
      defLeftVasaDetails = true;
    } else
    if (stage=="det_Rvasa"){
      defRightVasaDetails = true;
    }
  }
  
  public void stageAtt1(){
    vasa.startAppear();
  }
  
  public void stageAtt2(){
    vasa.startDisapper(); // !startDisappear();
  }
  
  public void stageAtt3(){
    leftFace.startAppear();
  }
  
  public void stageAtt4(){
    leftFace.startDisapper(); // !startDisappear();
  }
  
  public void stageAtt5(){
    rightFace.startAppear();
  }
  
  public void stageAtt6(){
    rightFace.startDisapper(); // !startDisappear();
  }
  
  int level=0;
  boolean levelChanged = false;
  int highMedThreshold=50, highAttThreshold=50;
  
  ActionTimer AttTimer = new ActionTimer(1000), MedTimer = new ActionTimer(1000);
  
  public boolean focusFace(){
    return (level%2 != 0);
  }
  
  public boolean focusVase(){
    return (level%2 == 0);
  }
  
  float levelSpeed = 0.02f;
  int maxArcs = 100;
  boolean influenceOppacity = true;
  public boolean nextLevel(float A, float M){
    if (focusVase()){
      // levels; 0,2,4,6,8,10
        if ((A >= highAttThreshold) && (AttTimer.itsDurationEnough())){
          highAttThreshold += 5;
          if (highAttThreshold>100)
            highAttThreshold = 100;
            
          //arcsAdding.changeStartEndV(0, highAttThreshold );
          level += 1;
          levelChanged = true;
          
        }
    } else {
      if ((M >= highMedThreshold) && (MedTimer.itsDurationEnough())){
          highMedThreshold += 5;
          if (highMedThreshold > 100)
            highMedThreshold = 100;
            
          //arcsAdding.changeStartEndV(M, 10);
          level += 1;
          levelChanged = true;
          
          // VASA appearing!
          
          //          arcs.active = true;
          //arcs.changeStartEndV(0, highAttThreshold, 0, highAttThreshold * 2);
        }
    }
    
    arcs.active = true;
    
    if (levelChanged)
    {
      String message = "";
      notify.addText("Level: " + str(this.level) + "!");
      AttTimer.refresh();
      MedTimer.refresh();
      if (focusFace()){
        message = "Clear your mind, clear Vase. Try to see faces...";
        arcs.changeStartEndV(0,highMedThreshold*2/3, arcs.realV, 0);
      } else {
        arcs.changeStartEndV((highAttThreshold/5), highAttThreshold, 0, maxArcs * 2);
        message = "Focus on Vase. Try to see faces!";
      }
      notify.addText(message, (int) random(width/1.75f), 1);
      print(message+"!"+"\n");
      
    }
    
    if (levelChanged)
    {
      if (focusFace())
        vasa.startAppear();
      else
        // focusVasa()
        vasa.startDisapper();
      
      
      if (level >= 4){ // 4,6,8
        
        if ((vasa.appearing) && focusFace()){
          // HERE WE NEED A PARAMS for speed and details!!!
          leftFace.startAppear();
          rightFace.startAppear();
        } else {
          leftFace.startDisapper();
          rightFace.startDisapper();
        }
      }
      
      if (level >= 6){ // 4,6,8
        levelSpeed = 0.02f * ((level - 4)/2);
      }
      
      if (level >= 10){ // 4,6,8
        influenceOppacity = false;
        colorizing = true;
      }
      
      if (level >= 12){
        strokeWeight = 2;
      }
      
      maxArcs = 50+100*(level/2);
    }
    
    return levelChanged;
    
  }
  
  public void vaseUpdate(){
    
  }
}
int defW = 1029;

int min_arcs = 0, max_arcs=0;
public void AddRandArcs(int c, float speed){
  float scale = (float) img_width / defW;
  
  for (int i = 0; i< c; i++){
    int row = (int) random(defW);
    
    if (LeftBoundX[row] != 0){
    
    
      int y = (int) (scale * row);
      int x = (int) (scale * LeftBoundX[row]);
      int cenX = (int) (defW/2 * scale);
    
      bounds.add(add_arc(img_x + cenX, img_y + y, abs(cenX-x)*2, abs(cenX-x)*2/3, random(speed)));
    } else i --;
    //bounds.add(add_arc(vasaCenX, x, abs(vasaCenX-mouseX)*2, abs(vasaCenX-mouseX)*2/3, random(0.10)));
  }
  
    Collections.sort(bounds);
}

public void RemoveRandArcs(int c){
  int i = 0;
  while ((bounds.size() > 0) && (i<c)){
    bounds.remove((int) random(bounds.size()));
    i++;
  }
}

ValueSmoother arcs = new ValueSmoother(0,100,0,100,40,300);

public void balanceArcsC(){
  int curReal = bounds.size();
  int curAbstr = (int) arcs.getV();
  
  int c = curAbstr - curReal ;
  //print("BALANCE:"+c+"\n");
  
  if (c>0)
    AddRandArcs(c,stage.levelSpeed);
  else
    RemoveRandArcs(abs(c));
}
// it's the left Vasa side at 1029x1029 

int[] LeftBoundX = 
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 514, 181,
169, 164, 162, 162, 163, 163, 164, 164, 164, 165, 165, 166, 166, 166,
167, 167, 168, 168, 168, 169, 169, 169, 170, 170, 170, 171, 171, 171,
172, 172, 172, 173, 173, 173, 174, 174, 174, 174, 175, 175, 175, 175,
176, 176, 176, 176, 177, 177, 177, 177, 177, 178, 178, 178, 178, 178,
178, 179, 179, 179, 179, 179, 179, 179, 179, 180, 180, 180, 180, 180,
180, 180, 181, 181, 181, 181, 181, 181, 181, 181, 182, 182, 182, 182,
182, 182, 182, 183, 183, 183, 183, 183, 183, 183, 184, 184, 184, 184,
184, 184, 184, 185, 185, 185, 185, 185, 185, 185, 186, 186, 186, 186,
186, 186, 186, 187, 187, 187, 187, 187, 187, 188, 188, 188, 188, 188,
188, 189, 189, 189, 189, 189, 189, 190, 190, 190, 190, 190, 190, 191,
191, 191, 191, 191, 191, 192, 192, 192, 192, 192, 192, 193, 193, 193,
193, 193, 193, 194, 194, 194, 194, 194, 194, 195, 195, 195, 195, 195,
195, 196, 196, 196, 196, 196, 196, 196, 197, 197, 197, 197, 197, 197,
197, 197, 198, 198, 198, 198, 198, 198, 198, 198, 199, 199, 199, 199,
199, 199, 199, 199, 199, 199, 199, 199, 199, 200, 200, 200, 200, 200,
200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200,
200, 200, 200, 200, 200, 200, 201, 201, 201, 201, 201, 201, 201, 201,
201, 201, 201, 201, 201, 201, 201, 201, 201, 201, 201, 201, 201, 201,
201, 201, 202, 202, 202, 202, 203, 203, 203, 203, 204, 204, 204, 205,
205, 205, 206, 206, 207, 207, 207, 208, 208, 209, 209, 210, 210, 211,
211, 212, 212, 213, 213, 214, 214, 215, 215, 216, 217, 217, 218, 218,
219, 220, 220, 221, 221, 222, 223, 223, 224, 225, 225, 226, 227, 227,
228, 229, 230, 230, 231, 232, 232, 233, 234, 235, 235, 236, 237, 238,
239, 239, 240, 241, 242, 242, 243, 244, 245, 246, 247, 247, 248, 249,
250, 251, 252, 252, 253, 254, 255, 256, 257, 258, 258, 259, 260, 261,
262, 263, 264, 265, 266, 266, 267, 268, 269, 270, 271, 272, 273, 274,
275, 276, 277, 278, 279, 280, 281, 282, 283, 283, 284, 285, 286, 287,
288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301,
302, 303, 304, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316,
317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 329, 330, 331,
332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345,
346, 347, 348, 349, 349, 350, 351, 351, 352, 352, 353, 353, 354, 354,
354, 355, 355, 356, 356, 356, 357, 357, 357, 357, 358, 358, 358, 358,
359, 359, 359, 359, 359, 359, 359, 360, 360, 360, 360, 360, 360, 360,
360, 360, 360, 360, 360, 359, 359, 359, 359, 359, 359, 359, 358, 358,
358, 358, 357, 357, 357, 356, 356, 355, 355, 355, 354, 354, 353, 352,
352, 351, 351, 350, 349, 348, 348, 347, 346, 345, 344, 343, 343, 342,
341, 340, 339, 338, 337, 336, 335, 334, 333, 332, 331, 330, 329, 327,
326, 325, 324, 323, 322, 321, 320, 318, 317, 316, 315, 314, 312, 311,
310, 309, 308, 306, 305, 304, 303, 301, 300, 299, 297, 296, 295, 293,
292, 291, 289, 288, 286, 285, 283, 281, 279, 277, 276, 275, 275, 275,
275, 275, 275, 276, 276, 277, 277, 278, 279, 279, 280, 281, 281, 282,
282, 283, 284, 284, 285, 285, 286, 286, 286, 287, 287, 287, 288, 288,
288, 288, 288, 288, 289, 289, 289, 289, 289, 289, 289, 289, 289, 288,
288, 288, 288, 288, 288, 287, 287, 287, 286, 286, 286, 285, 285, 284,
284, 283, 282, 282, 281, 280, 280, 279, 278, 277, 277, 276, 276, 275,
275, 275, 275, 276, 278, 280, 281, 282, 283, 284, 285, 285, 286, 286,
287, 287, 288, 288, 288, 288, 289, 289, 289, 289, 289, 289, 289, 289,
289, 289, 289, 289, 289, 289, 289, 289, 289, 289, 289, 289, 289, 289,
288, 288, 288, 288, 288, 288, 287, 287, 287, 287, 287, 286, 286, 286,
285, 285, 285, 284, 284, 283, 283, 282, 282, 281, 281, 280, 280, 279,
278, 278, 277, 276, 276, 275, 274, 273, 273, 272, 271, 270, 269, 269,
268, 267, 266, 266, 265, 264, 264, 264, 263, 263, 262, 262, 262, 262,
261, 261, 261, 261, 261, 261, 261, 261, 261, 261, 261, 261, 261, 261,
261, 261, 262, 262, 262, 262, 262, 262, 262, 262, 262, 263, 263, 263,
263, 263, 263, 264, 264, 264, 264, 265, 265, 265, 265, 266, 266, 266,
266, 267, 267, 268, 268, 268, 269, 269, 270, 270, 270, 271, 271, 272,
272, 273, 273, 274, 275, 275, 276, 276, 277, 277, 278, 278, 279, 279,
280, 280, 281, 281, 282, 283, 283, 284, 284, 284, 285, 285, 286, 286,
287, 287, 288, 288, 288, 289, 289, 289, 290, 290, 290, 290, 291, 291,
291, 291, 291, 291, 291, 289, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
// utils function

public float toV(float from, float to, float add){
  float med = max(min(abs(to-from), add),0) * sign(to-from);
  return from + med;
}

public float sign(float v){
  if (v == 0)
    return v;
  else
    return abs(v)/v;
}
  public void settings() {  size(500,500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "vasa_short" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
