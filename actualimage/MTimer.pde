class Timer{
  HashMap<Integer, Integer> timers  = new HashMap<Integer, Integer>(); // id -> time
  HashMap<Integer, Integer> timersN = new HashMap<Integer, Integer>(); // id -> time
  
  void reset(){
    timers  = new HashMap<Integer, Integer>(); // id -> time
    timersN = new HashMap<Integer, Integer>(); // id -> N
  }
  
  boolean on_timer(int id, int ts_dt){
    if (timers.containsKey(id)){
      int ts = timers.get(id);
      int dt = millis() - ts;
      
      if (dt > ts_dt){
        timers.put(id, millis() + (ts_dt - dt));
        timersN.put(id, timersN.get(id) + 1);
        return true;
      }
      
      return false;
    } else {
      timers.put(id, millis());
      timersN.put(id, 0);
      return false;
    }
  }
  
  boolean on_timer_N(int id, int ts_dt, int N){
    if (timers.containsKey(id)){
      int ts = timers.get(id);
      int dt = millis() - ts;
      
      if (dt > ts_dt){
        timers.put(id, millis() + (ts_dt - dt));
        timersN.put(id, timersN.get(id) + 1);
        
        if (timersN.get(id) >= N)
          return true;
      }
      
      return false;
    }
    else {
      timers.put(id, millis());
      timersN.put(id, 0);
      return false;
    } 
  }
  
  
}

Timer timer = new Timer();