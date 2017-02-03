class Smoother{
  float[] coefs = {0.05, 0.1, 0.15, 0.2, 0.2, 0.3};
  float[] v = new float[6];
  
  Smoother(){
    for(int i=0;i<v.length;i++){
      v[i] = 0;
    }
  }
  
  float addV(float V){
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

class SmootherTimer extends ActionTimer{
  // bad design. rlly ActionTimer and Smoother are different
  SmootherTimer(float dt, float speed, float startV, float resStartV, float resEndV, float endV, int smoothType){
    super(dt);
    this.vPerSec = speed; // speed of curV change [or vPerVal]
    this.startV = startV;
    this.endV = endV;
    this.smoothType = smoothType;
    this.curV = startV;
    this.resStartV = resStartV;
    this.resEndV = resEndV;
  }
  
  void changeStartEndV(float startV, float endV){
    this.startV = startV;
    this.endV = endV;
  }
  
  void changeStartEndV(float startV, float endV, float resStartV, float resEndV){
    this.startV = startV;
    this.endV = endV;
    this.resStartV = resStartV;
    this.resEndV = resEndV;
  }
  
  float vPerSec, startV, endV, curV;
  float resStartV, resEndV;
  
  int smoothType;
  
  float sign(float v){
    if (v == 0)
      return v;
    else
      return abs(v)/v;
  }
  
  float toSeekV(){
    float time = millis();
    switch(smoothType){
      case 1:{ //linear
        float dV = (time - lastTime) * vPerSec;
        
        if ((startV <= curV) && (curV < endV)){
          curV += dV;
          if (curV >endV)
            curV = endV;
        } else
        if ((startV >= curV) && (curV > endV)){
          curV -= dV;
          if (curV <endV)
            curV = endV;
        } else
          curV -= sign(startV - curV) * dV; 
        
          return curV;
        //break;
      }
      default:
        
        break;
    }
    return 0;
  }
  
  float toSeekV(float realV){ // realV is not curV. realV it's Attention of Meditation
    float vPerVal = vPerSec;
    
    switch(smoothType){
      case 1:{ //linear
        //float dV = (realV - endV) * vPerVal;
        float dV = (resStartV - resEndV) * vPerVal;
        
        if ((startV <= realV) && (realV < endV)){
          curV += dV;
          if (curV >endV)
            curV = endV;
        } else
        if ((startV >= realV) && (realV > endV)){
          curV -= dV;
          if (curV <endV)
            curV = endV;
        } else
          curV -= sign(startV - curV) * dV; 
        
          return curV;
        //break;
      }
      default:
        
        break;
    }
    return 0;
  }
  
  
  
}