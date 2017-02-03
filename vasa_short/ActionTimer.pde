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
  
  boolean itsDurationEnough(float time){
    if (time - lastTime > duration){
      livetime += (time - lastTime);
      lastTime = time;
      return true;
    } else return false;
  }
  
  boolean itsDurationEnough(){
    return itsDurationEnough(millis());
  }
  
  void refresh(){
    this.lastTime = millis();
    
  }
  
  boolean isOver(){
    if (( liveTimeMax != -1) && ((millis() - liveTimeStart) >liveTimeMax)){
      return true;
    } else return false;
  }
  
  float toCountOver(float c){
    if ( liveTimeMax != -1){
      if (millis() - liveTimeStart > liveTimeMax){
        return c;
      } else return c * (millis() - liveTimeStart)/ (liveTimeMax);
    }
    return 0;
  }
}