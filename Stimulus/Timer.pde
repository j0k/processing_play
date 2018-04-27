class Timer{
  HashMap<Integer, Integer> timers = new HashMap<Integer, Integer>(); // id -> time
  
  boolean on_timer(int id, int ts_dt){
    if (timers.containsKey(id)){
      int ts = timers.get(id);
      int dt = millis() - ts;
      
      if (dt > ts_dt){
        timers.put(id, millis() + (ts_dt - dt));
        return true;
      }
      
      return false;
    } else {
      timers.put(id, millis());
      return false;
    }
  }
  
  int newID(){
    // f*ck style
    for(int i = 0; i < 1000; i++){
      if (!timers.containsKey(i)){
        return i;
      }      
    }
    return -1;
  }
}

Timer timer = new Timer();