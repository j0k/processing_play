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
    print(vMap +"@");
    realVs.add(vMap);
    float realVtmp = realVs.getV();
    println("##"+realVtmp);
    if (abs(realVtmp - realV) > maxRealVPerSec * (time/1000)){
      realV = sign(realVtmp) * maxRealVPerSec * (time/1000);
      println("@@"+realV);
    }
     
    realV = between(realV, startRealV, endRealV);
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
  
  float sign(float v){
    if (v == 0)
      return v;
    else
      return abs(v)/v;
  }
  
  void printIt(){
    
    
    print("V:"+realV+"\n");
  }
}