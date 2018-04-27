static interface PSY {
  static int
  ATTENTION    = 0,
  MEDITATION   = 1,
  BASIC       = -1,
  D_ATT_MED    = 2,
  ALL_PARAMS   = -2;
};

static final boolean needCalc[] = {false, false, true};
// new boolean[PSY.ALL_PARAMS+1]

class MinV{
  float v = 0.0;
  boolean active   = false;
  boolean needCalc = false;
  Timing lastTSU = new Timing(); // last ts update;

  MinV(boolean active, float v){
    this.v = v;
    this.active = active;
  }
}

// new PsyDyn(new int[]{PSY.ALL_PARAMS});
class PsyDyn{
  int dyn_type = PSY.BASIC;
  int tnum = 0;
  
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
  
  int size(){
    return tnum + 1;
  }
  
  void up_value(float v, int num){
    if (params[num].active)
      params[num].v = v;        
  }
  
  void up_att(float v){
    if (params[PSY.ATTENTION].active)
      params[PSY.ATTENTION].v = v;
  }
  
  void up_med(float v){
    if (params[PSY.MEDITATION].active)
      params[PSY.MEDITATION].v = v;
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
  
  
  MinV[] params;
  // params[0] - attention
  // params[1] - meditation
  // params[2] - difference
  
  Timing lastTSU = new Timing();
  
    
  void up_AttMed(float att, float med){
    up_value(att, PSY.ATTENTION);
    up_value(med, PSY.MEDITATION);
  }

  void up_time(Timing time){
    lastTSU = time;
  }
  
  void calc_parameters(){
  }
  
}