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
}

Timer timer = new Timer();