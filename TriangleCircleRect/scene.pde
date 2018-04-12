static interface STATE{
  static int 
  TRIANGLE       = 0,
  CIRCLE         = 1,
  RECT           = 2,
  CIRCLE_COLORED = 3,
  RECT_COLORED   = 4,
  FINAL_STATE    = 5;
}

//ArrayList<State> states;
StateMachine SM;
void sceneSetup(){  
  // init states
  ArrayList<State> states;
  states = new ArrayList<State>();
  states.add(new State(gmetrics.size(), 1, STATE.TRIANGLE));
  states.get(0).set_params(new boolean[]{false,false}, new int[][]{{0,0},{0,0}});
  
  states.get(0).ts_moment_min = 100;
  states.get(0).ts_moment_max = 1000;
  states.add(new State(gmetrics.size(), 2, STATE.CIRCLE));
  states.get(1).set_params(new boolean[]{true,false}, new int[][]{{35,100},{0,0}});
  
  states.add(new State(gmetrics.size(), 2, STATE.RECT));
  states.get(2).set_params(new boolean[]{false,true}, new int[][]{{0,0},{35,100}});
  states.get(2).ts_moment_min = 1000;
  
  states.add(new State(gmetrics.size(), 3, STATE.CIRCLE));
  states.get(3).set_params(new boolean[]{true,false}, new int[][]{{80,100},{0,0}});

  states.add(new State(gmetrics.size(), 3, STATE.RECT));
  states.get(4).set_params(new boolean[]{false,true}, new int[][]{{0,0},{80,100}});
  states.get(4).ts_moment_max = 1000;
  
  // init stateMachine
  HashMap<Integer, Integer[]> trans = new HashMap<Integer, Integer[]>();
  trans.put(STATE.TRIANGLE, new Integer[]{STATE.CIRCLE, STATE.RECT});
  trans.put(STATE.CIRCLE, new Integer[]{STATE.TRIANGLE, STATE.CIRCLE_COLORED});
  trans.put(STATE.CIRCLE_COLORED, new Integer[]{STATE.CIRCLE});
  trans.put(STATE.RECT, new Integer[]{STATE.TRIANGLE, STATE.RECT_COLORED});
  trans.put(STATE.RECT_COLORED, new Integer[]{STATE.RECT});
  
  RTransitions ftrans = new RTransitions();
  
  State[] statesA = new State[states.size()];
  statesA = states.toArray(statesA);
  SM = new StateMachine(statesA, 0, trans, ftrans);
  SM.DEBUG_TRANS = false;
  
  //SM.track_task();
  
  // run
}

void drawScene(){
  float x = width/2;
  float y = height/2;
  float rad = 140;
  
  switch(SM.cur_state){
    case STATE.TRIANGLE:{
      fill(140,140,200);
      triangle(x-70,y-20,x,y+50,x+70,y-20);
      break;
    }
    case STATE.CIRCLE:{
      fill(140,140,200);
      ellipse(x,y,rad,rad);
      break;
    }
    case STATE.RECT:{
      fill(140,140,200);
      rect(x-rad/2,y-rad/2,rad,rad);
      break;
    }
    case STATE.RECT_COLORED:{
      fill(140,240,240);
      rect(x-rad/2,y-rad/2,rad,rad);
      break;
    }
    case STATE.CIRCLE_COLORED:{
      fill(240,140,240);
      ellipse(x,y,rad,rad);
      break;
    }
  }
}