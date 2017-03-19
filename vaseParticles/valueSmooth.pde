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
  
  void addV(float v){
    coords.add(v);
  }
  
  float lasttime, lasttime_micro;
  float realVtmp;
  
  float getV(){
    float time = millis() - lasttime;
    float r;
    if (time >= msPerUp){
      r = getVChanged();
    } else {
      r = getVMicro();
    }
    
    return r;
  }
  
  float getVMicro(){
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
    
  float getVChanged(){
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
  

  void changeStartEndV(float startV, float endV, float startRealV, float endRealV){
    this.startV = startV;
    this.endV = endV;
    this.startRealV = startRealV;
    this.endRealV = endRealV;
  }
  
  void printIt(){
    
    
    print("V:"+realV+"\n");
  }
}