interface PSYEXP{
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
    exp[0]  = att;
    exp[1]  = med;
    exp[2]  = swi;
  }
  
  PSYExp add(PSYExp exp_add){
    PSYExp en = new PSYExp(); // exp new
    for(int i = 0; i<exp.length; i++){
      en.exp[i] = exp[i] + exp_add.exp[i]; 
    }
    
    return en;
  }
  
  PSYExp add_to(PSYExp exp_to){    
    for(int i = 0; i<exp.length; i++){
      exp_to.exp[i] = exp[i] + exp_to.exp[i]; 
    }    
    return exp_to;
  }   
  
  String str(){
    return "Att: " + exp[0] + "; Med: " + exp[1] + "; Swi: " + exp[2];
  }
   
}

// Table[10*((i^2.1 + 1)) // N, {i, 1, 80}]
// Solve[10*((i^2.1 + 1)) == x, {i}]
// {{i -> 0.334048 (-10. + x)^0.4761904761904762}}
float to_level(float x){
  return  0.334048 * pow(- 10. + x, 0.4761904761904762);
}

float from_level(float x){
  return 10 * (pow(x,2.1) + 1);
}

float[] to_LPV(float x){
  float pl   = floor(to_level(x));
  float v_pl = from_level(pl);     // prev level
  float v_nl = from_level(pl + 1); // next level
  float d_V1 = max(x - v_pl, 0);
  float d_V2 = v_nl - v_pl;
  
  float[] res = new float[3];
  res[0] = pl;
  res[1] = max(100, 100*d_V1/d_V2);
  res[2] = x;
  
  return res;
}

String LPV_str(float[] LPV){
  return "Level: " + int(LPV[0]) + "; Progress: " + nf(LPV[1],3,2) + "; Value: "+LPV[2];
}