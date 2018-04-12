static interface PSYST {
  static int
  NOT_TOUCHED = 0,
  OPEN        = 1, 
  INSIDE      = 2, 
  CLOSED      = 3;  
};

class StateType{
  boolean active   = true;
  boolean is_final = false;
  int status;
  
  int ts_in_state     = 0;
  int ts_in_psyparams = 0;
  int priority        = 0;
}

class State extends StateType implements IReset, IUp{
  boolean[] active_bound;
  float[][] bounds;
  String title = "";
  boolean DEBUG = false;
  PSYExp exp = null;
  
  int id, gid;
  State(int N, int priority, int gid){
    bounds        = new float[N][2];
    active_bound  = new boolean[N];
    
    this.gid      = gid;
    this.priority = priority;
    
    reset();
  }
  
  void set_params( boolean[] active_bound, int[][] bounds){
    for(int i=0; i<bounds.length;i++){
      for(int j=0; j<2; j++){
        this.bounds[i][j] = bounds[i][j];
      }
      this.active_bound[i] = active_bound[i];
    }
  }
  
  void set_params(int[][] bounds){
    boolean[] actives = new boolean[bounds.length];
    
    for(int i=0; i<bounds.length;i++){
      actives[i] = true;
    }
    
    set_params(actives, bounds);
  }
  
  
  int ts_cumsum, ts_moment, ts_cumsum_psy, ts_moment_psy;  
  // time in state, time is state from last came_in 
  
  int ts_cumsum_min, ts_cumsum_max, ts_moment_min, ts_moment_max;
  int ts_cumsum_psy_min, ts_cumsum_psy_max;
  int ts_moment_psy_min, ts_moment_psy_max;
    
  void reset(){
    ts_cumsum   = 0; // in state
    ts_moment   = 0;
    
    ts_cumsum_psy = 0;
    ts_moment_psy = 0;
    
    ts_cumsum_min = -1;
    ts_cumsum_max = -1;
    ts_moment_min = -1;
    ts_moment_max = -1;        
  
    ts_cumsum_psy_min = -1;
    ts_cumsum_psy_max = -1;
    ts_moment_psy_min = -1;
    ts_moment_psy_max = -1;
  
    status = PSYST.NOT_TOUCHED;           
  }
  
  void set_ts_minmax(int ts_cumsum_min, int ts_cumsum_max, int ts_moment_min, int ts_moment_max){
    this.ts_cumsum_min = ts_cumsum_min;
    this.ts_cumsum_max = ts_cumsum_max;
    this.ts_moment_min = ts_moment_min;
    this.ts_moment_max = ts_moment_max;    
  }   
  
  boolean timing_expired(){
    // we have to go out from current_state
    return (ts_cumsum_max > 0 && ts_cumsum_max <= ts_cumsum)
            || (ts_moment_max > 0 && ts_moment_max <= ts_moment) ;
  
  }
  
  boolean timing_psy_expired(){
    // we have to go out from current_state
    return (ts_cumsum_psy_max > 0 && ts_cumsum_psy_max <= ts_cumsum_psy)
            || (ts_moment_psy_max > 0 && ts_moment_psy_max <= ts_moment_psy) ;
  
  }
  
  boolean timing_psy_satisfy(){
     return (ts_cumsum_psy_min < 0 || ts_cumsum_psy_min <= ts_cumsum_psy)
        && (ts_moment_psy_min < 0 || ts_moment_psy_min <= ts_moment_psy) ;
  }
  
  boolean timing_satisfy(){    
    // we can go out from current state
    //
    // example max in state 60 sec, in param 20 sec or moment in param 10 sec min in state 30 sec
    // ts_cumsum_min = 30, ts_cumsum_max = 60
    // 
    return (ts_cumsum_min < 0 || ts_cumsum_min <= ts_cumsum)
      && (ts_moment_min < 0 || ts_moment_min <= ts_moment) ;
  }
  
  boolean is_fit(PsyDyn metrics){
    
    boolean fit = true;
    for(int i = 0; i < metrics.params.length; i++){
      MinV param = metrics.params[i];
      if (DEBUG){
        println("_" + active_bound.length + " - " + metrics.params.length + " [" + param.v );
        println(param);
        println(active_bound[i]);
      }
      if (param.active && active_bound[i]){
        fit &= (bounds[i][0] <= param.v);
        fit &= (param.v <= bounds[i][1]);
        
        if (!fit)
          return false;
      }
    }
    return fit;
  }
  
  Timing time;
  boolean psy_state_satisfy = false;
  void up_psy(PsyDyn metrics, Timing time){    
    up(time);    
    
    switch(status){
      case PSYST.NOT_TOUCHED:
          {
            break;
          }
        case PSYST.OPEN:
          {            
            break;
          }
        case PSYST.INSIDE:
          { 
            ts_cumsum += time.dt;
            ts_moment += time.dt;
            
            psy_state_satisfy = is_fit(metrics);
            if (psy_state_satisfy){
              ts_cumsum_psy += time.dt;
              ts_moment_psy += time.dt;
            }
            break;
          }
        case PSYST.CLOSED:
          {
            break;
          }           
    }
  }
  
  
  void up(Timing dt){
    time = dt;      
  }
  
  void changeState(int status){    
    this.status = status;   
    
    switch(status){
      case PSYST.INSIDE:
        {
          ts_moment = 0;
          ts_moment_psy = 0;
        }
    }
  }
  
  boolean transition_ready(){
    return timing_expired() || timing_psy_expired();
  }
  
  // void come_in(){}
  // void come_out(){}
}