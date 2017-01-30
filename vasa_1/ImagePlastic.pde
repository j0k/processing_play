class ImagePlastic {
  PImage img;
  float transpPerSec; // 255 per second means that we need 1 sec to appear
  boolean visible = true;
  
  int img_x, img_y, img_width, img_height;
  float oppacity=0;
  
  void draw(){
    tint(255, oppacity);
    image(img, img_x, img_y, img_width, img_height);
  }
  
  boolean updated = false;
  void update(){
    time = millis();
    
    float dt = time - lastOppacityChangeTime;
    
    print("\n + a:" + appearing + " disa:" +disappearing + "  " + time + " dt:" +dt + " op:"+ this.oppacity+"\n");
    if (disappearing){
      int opp = setTranspPerSec(dt);
      oppacity = oppacity - opp;
      if (oppacity < 0){
        oppacity = 0;
        disappearing = false;
      }
      
      updated = true;
    }
    
    if (appearing){
      //print("Appear" + oppacity + "-" + appearing);
      int opp = setTranspPerSec(dt);
      oppacity = oppacity + opp;
      if (oppacity >= 255){
        oppacity = 255;
        appearing = false;
        endAppearing = true;
      }
      
      updated = true;
    }
    
    if (updated){
      updated = false;
      lastOppacityChangeTime = time;
    }
  }
  
  ImagePlastic (PImage img, int x, int y, int w, int h, float tPS){
    this.img = img;
    this.img_x = x;
    this.img_y = y;
    this.img_width = w;
    this.img_height = h;
    this.transpPerSec = tPS;
  }
  
  int setTranspPerSec(float dtime){
    float opp = (dtime/1000) * transpPerSec;
    print("OPP: " + opp);
    return (int) opp;
    // 1000 ms = 1 sec
  }
  
  float lastOppacityChangeTime = 0;
  float time;
  
  boolean appearing = false;
  boolean endAppearing = false;
  
  boolean disappearing = false;
  boolean endDisappearing = false;
  
  void startAppear(){
    endDisappearing = false;
    appearing = true;
    disappearing = false;
  }
  
  void startDisapper(){
    endAppearing = false;
    disappearing = true;
    appearing = false;
  }
  
  void loop(){
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
}