// about enum
// https://forum.processing.org/two/discussion/9877/how-to-use-enums

static interface PSY {
  static int
  NOT_TOUCHED = 0,
  OPEN        = 1, 
  INSIDE      = 2, 
  CLOSED      = 3;  
};

String PSY2S(int v){
  if (v == PSY.NOT_TOUCHED)
    return "NOT_TOUCHED";
  else if (v == PSY.OPEN)
    return "OPEN";
  else if (v == PSY.INSIDE)
    return "INSIDE";
  else if (v == PSY.CLOSED)
    return "CLOSED";
  else 
    return "DONT KNOW";
}

// minimal physio state
class MinState{
  String title;
  int state = 0;
  float min_time, max_time;
  float time_in;
  float l,r;
  float value;
  
  MinState(String title, float l, float r, bool active, float min_time, float max_time){
    this.l = l;
    this.r = r;
    this.title = title;
    this.active = active;
    this.min_time = min_time;
    this.max_time = max_time;
    
    time_in = 0;
    this.state = 1;//PSY.NOT_TOUCHED;
  }

  float last_visit_INSIDE = 0;
  float time_in_INSIDE;
  float time_in_CLOSED;

  void changeState(int state){
    if (state = PSY.INSIDE){
      last_visit_INSIDE = millis();
    }
    this.state = state;    
  }

  
  void update(float value){
    
    if (state != PSY.NOT_TOCHED){
      
    }
  }
};

class MindState extends MinState{
  MinState[] states;
  String title;

  MindState(String title, bool att_active, float attL, float attR, bool med_active, float medL, float medR, float min_time, float max_time ){
    super(title, 0, 0, true, min_time, max_time);
    //this.title = title;
    states = new MinState[2];
    
    MinState attS = new MinState("Att", attL, attR, att_active, min_time, max_time);
    MinState medS = new MinState("Med", medL, medR, med_active, min_time, max_time);
    states[0] = attS;
    states[1] = medS;
    this.state = 1;// PSY.NOT_TOUCHED;
  }

  void update(float att, float med){
    states[0].update(att);
    states[1].update(med);
  }
}

class StateMachine{
  MindState[] states;
  int cur_state = 0;

  bool end_last_state = false;
  StateMachine(MindState[] states, int start){
    this.states = states;
    print(this.states.length);
    this.states[0].state = PSY.OPEN;
    print("Closed is : #" +PSY.CLOSED);
    //print(PSY2S(this.states[0].state) );
    //print(str(this.states[0].state));
    
    if (states.length > start){
      this.states[start].changeState(PSY.OPEN);
      cur_state = start;
      end_last_state = false;
    }
  }

  MindState cs(){
    return this.states[cur_state];
  }

  void update_values(float att, float med){
    MindState ms = states[cur_state];
    ms.update(att, med);
    if (ms.state == PSY.CLOSED){
      if (cur_state < states.length){
        //cur_state ++;
        //this.states[cur_state].changeState(PSY.OPEN);
      } else {
        end_last_state = true;
      }
    }
  }

};

// MinState AState;