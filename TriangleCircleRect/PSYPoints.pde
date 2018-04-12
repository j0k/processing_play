static interface PSYEXP{
  static int 
  ATTENTION  = 0,
  MEDITATION = 1,
  SWINGING   = 2;
}

class PSYExp{
  float[] exp = new float[3];
  
  PSYExp(){
    for(int i = 0; i<exp.length; i++){
      exp[i] = 0;
    }
  }
  
  PSYExp(float att, float med, float swi){
    exp[PSYEXP.ATTENTION]  = att;
    exp[PSYEXP.MEDITATION] = med;
    exp[PSYEXP.SWINGING]   = swi;
  }
  
  PSYExp add(PSYExp exp_add){
    PSYExp en = new PSYExp();
    for(int i = 0; i<exp.length; i++){
      en.exp[i] = exp[i] + exp_add.exp[i]; 
    }
    
    return en;
  }
}