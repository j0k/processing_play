  
import java.util.Map;

class FTransitions {  
  void trans(int f, int t, StateMachine SM){
    // from state, to state
  };
};

class StateMachine implements IReset, IUp{
  boolean DEBUG_TRANS = false;
  State[] states;
  HashMap<Integer , Integer[]> trans;
  
  String title = "";
  int cur_state = 0;
  int start_state = 0;
  int end_state = -1;
  
  FTransitions ftrans;
  

  StateMachine(State[] states, int start_state, HashMap<Integer, Integer[]> trans, FTransitions ftrans){
    //  FTransitions ftrans
    this.states = states;    
    this.start_state = start_state;
    this.trans = trans;    
    this.ftrans = ftrans;
  }

  void reset(){    
    for(int i = 0; i < states.length ; i++){
      this.states[i].reset();
    }
    
    cur_state = start_state;
  }

  State cs(){
    // current state
    return this.states[cur_state];
  }

  Timing time;
  void up(Timing dt){
    time = dt;
  }
  
  void up_psy(PsyDyn metrics){
    State state = cs();    
    //state.up_psy(metrics, time);
    
    boolean go_exit = false;
    int     next_state = -1;
    while(!go_exit){
      switch(state.status){
        case PSYST.NOT_TOUCHED:
          {
            state.changeState(PSYST.OPEN);
            break;
          }
        case PSYST.OPEN:
          {
            state.changeState(PSYST.INSIDE);
            break;
          }
        case PSYST.INSIDE:
          {            
            state.up_psy(metrics, time);
            
            if (state.psy_state_satisfy){
              go_exit = true;
            }
            
            //println("TMSTF:"+state.timing_satisfy());
            if (!state.timing_satisfy() || !state.timing_psy_satisfy()){
              go_exit = true;
              break;
            }
                        
            if (!state.psy_state_satisfy || state.transition_ready()){              
              state.changeState(PSYST.CLOSED);              
            }
            else {
              next_state = have_better_transition(metrics);
              if(timer.on_timer(2,1000)){
                // println("NS:" + next_state);
              }
              if (next_state >= 0){
                state.changeState(PSYST.CLOSED);
              }
            }              
            
            break;
          }
        case PSYST.CLOSED:
          {
            if (next_state >= 0){
              make_transition(next_state);
            } else
            transition_try(metrics);
            go_exit = true;
            break;
          }            
      }
    }    
  }

  int transition_try(PsyDyn metrics){
    int go_trans = choose_new_state(metrics, false);

    if (go_trans != -1)
      make_transition(go_trans);
      
     return go_trans;
  }

  int have_better_transition(PsyDyn metrics){
    return choose_new_state(metrics, true);
  }
  
  int choose_new_state(PsyDyn metrics, boolean need_better){
    // by transition matrix
    State state = states[cur_state];    
    
    if (trans.containsKey(cur_state)) {
      int n_prior      =  0;            
      int i_prior      = -1;
      
      if(!need_better)
        n_prior = -10000;
            
      for(int ind : trans.get(cur_state))
      {
        boolean is_fit = states[ind].is_fit(metrics);    
        
        if (!is_fit)
          continue;
          
        if (need_better){
          if (states[ind].priority - state.priority > n_prior){
            n_prior = states[ind].priority - state.priority;
            i_prior = ind;
          }
        } else {
          if (states[ind].priority > n_prior){
            n_prior = states[ind].priority;
            i_prior = ind;
          }
        }
      }
      return i_prior;
    }
    return -1;
  };

  int make_transition(int next_state){
    if (next_state == -1)
      return -1;
    
    ftrans.trans(cur_state, next_state, this);
    
    if(DEBUG_TRANS)
      println("go to " + next_state+">");
    states[next_state].changeState(PSYST.OPEN);
    cur_state = next_state;    
    
    return next_state;
  };
  
  String print_status(){
    return "title: " +title + " ("+millis()+")"+". state: " + cur_state + "(" + cs().gid + "). status: " + cs().status + ". fit: "+ ". ts:"+cs().ts_moment;
  }

};