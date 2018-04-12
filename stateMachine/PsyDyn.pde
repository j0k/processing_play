static interface PSY {
  static int
  ATTENTION    = 0,
  MEDITATION   = 1,
  BASIC       = -1,
  D_ATT_MED    = 2,
  ALL_PARAMS   = -2;
};

class MinV{
  float v = 0.0;
  boolean active = false;
  int lastTSU = 0; // last ts update;

  MinV(boolean active, float v){
    this.v = v;
    this.active = active;
  }
}

// new PsyDyn(new int[]{PSY.ALL_PARAMS});
class PsyDyn{
  int dyn_type = PSY.BASIC;
  PsyDyn(int dyn_activations){
    // check for common activation
    if (dyn_activations < 0){
      this.tnum = abs(dyn_activations);      
    }       
        
    params = new MinV[tnum + 1];
    
    for(int i= 0; i<tnum+1;i++){
      params[i] = new MinV(true, 0);
    }           
  }
  
  void up_value(float v, int num){
    if (params[num].active)
      params[num].v = v;        
  }
  
  
  
  float get_value(int num){
    return params[num].v;
  }
  
  float get_att(){
    return get_value(PSY.ATTENTION);
  }
    
  float get_med(){
    return get_value(PSY.MEDITATION);
  }
  
  float get_D_att_med(){
    return get_value(PSY.D_ATT_MED);
  }
  
  int tnum;
  MinV[] params;
  // params[0] - attention
  // params[1] - meditation
  // params[2] - differect

  float att = 0.0;
  float med = 0.0;
  float dAttMed = 0.0;
  
  int lastTimeUpdate = 0;

  void up_att(float att){
    this.att = att;
    this.dAttMed = att - med;
  }
  
  void up_med(float med){
    this.med = med;
    this.dAttMed = att - med;
  }  
  
  void up_AttMed(float att, float med){
    this.att = att;
    this.med = med;
    this.dAttMed = att - med;
  }

  void up_time(int time){
    lastTimeUpdate = time;
  }

  void setType(){
  }
}