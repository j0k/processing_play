class EEGEmulator{
  ActionTimer t = new ActionTimer(500);
  
  int dV = 6;
  float A=50, M=50;
  
  void update(){
    float dA = dV/2 - random(dV), dM = dV/2 - random(dV);
    
    if (t.itsDurationEnough()){
      this.A += dA;
      this.M += dM;
    }
  }
  
  void update(float A, float M){
    this.A = A;
    this.M = M;
    float dA = dV/2 - random(dV), dM = dV/2 - random(dV);
    
    if (t.itsDurationEnough()){
      this.A += dA;
      this.M += dM;
    }
  }
}