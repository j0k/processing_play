class Smoother{
  float[] coefs = {0.05, 0.1, 0.15, 0.2, 0.2, 0.3};
  float[] v = new float[6];
  
  Smoother(){
    for(int i=0;i<v.length;i++){
      v[i] = 0;
    }
  }
  
  float add(float V){
    for(int i=1;i<v.length;i++){
      v[i-1] = v[i];
    }
    v[5] = V;
    return V;
  }
  
  float getV(){
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
  
  void addV(float v){
    coords.add(v);
  }
  
  float lasttime, lasttime_micro;
  float realVtmp;
  
  boolean active = true;
  float getV(){
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