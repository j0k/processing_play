class PsyM{
  PsyM(){
  }
  
  float[] params; 
  
  float get_attention(){
    return params[0];
  }
  
  float get_meditation(){
    return params[1];
  }
  
  float get_diff_att_med(){
    
  }
  
  void up_param(float value, int tnum){
    params[tnum] = value;
  }
}


class PsyBound{
}

class PsyMin{
  boolean active=false;
  float v;
  int last_up_time;
}

class Bounds{
  boolean active = true;
  float[] b;
}

class State{
  ArrayList<Bounds> b;
  int time=0, time_inside=0, time_cum=0;
  //Array<boolean> 
}

class StateMachine{
  State[] states;
  int cur_state;
  
  void set_translations(){}
  
  void up(PsyDyn metrics, int dt, int abs_ts){
    for 
  }
}