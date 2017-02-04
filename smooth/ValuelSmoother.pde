class ValueSmoother{
  Smoother coords = new Smoother();
  Smoother realVs = new Smoother();
  
  float startV, endV;
  float startRealV, endRealV;
  
  float curV;
  float realV;
  
  float maxRealVPerSec;
  
  ValueSmoother(float startV, float endV, float startRealV, float endRealV, float maxRealVPerSec){
    this.startRealV = startRealV;
    this.endRealV = endRealV;
    this.startV = startV;
    this.endV = endV;
    this.maxRealVPerSec = maxRealVPerSec;
  }
  
  void addV(float v){
    coords.add(v);
  }
  
  float lasttime;
  float getVUp(){
    float time = millis() - lasttime;
    
    curV = coords.getV(); // it's
    curV = between(curV, startV, endV);
    
    float vMap = map(curV, startV, endV, startRealV, endRealV);
    
    realVs.add(vMap);
    
    
    float realVtmp = realVs.getV();
    
    if (abs(realVtmp - realV) > maxRealVPerSec * (time/1000)){
<<<<<<< HEAD
      realV = toV(realV, between(realVtmp, startRealV, endRealV), maxRealVPerSec * (time/1000)) ;//sign(realVtmp) * maxRealVPerSec * (time/1000);
      println("@@"+realV);
    } else {
      realV = realVtmp;
    }
=======
      realV = sign(realVtmp) * maxRealVPerSec * (time/1000);
      
    } else { realV = realVtmp; }
>>>>>>> 735c2862b68afe2f3090dd79231c259c8c1c52bb
     
    //realV = between(realV, startRealV, endRealV);
    lasttime = time;
    return realV;
    
  }
  
  float between(float v,float  vLeft,float vRight){
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
  
<<<<<<< HEAD
 
=======
  float sign(float v){
    if (v == 0)
      return v;
    else
      return abs(v)/v;
  }
  
  void changeStartEndV(float startV, float endV, float startRealV, float endRealV){
    this.startV = startV;
    this.endV = endV;
    this.startRealV = startRealV;
    this.endRealV = endRealV;
  }
  
  
>>>>>>> 735c2862b68afe2f3090dd79231c259c8c1c52bb
  void printIt(){
    
    
    print("V:"+realV+"\n");
  }
}