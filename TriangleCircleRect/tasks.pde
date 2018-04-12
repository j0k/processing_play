import java.util.List;

static interface STATETASK{
  static int 
  TRIANGLE       = 0,
  CIRCLE         = 1,
  RECT           = 2,
  FINAL_STATE    = 3;
}

StateMachine task_SM;
void setupTasks(){
  StateMachine taskTRCE;
  
  ArrayList<State> states = new ArrayList<State>();
  states.add(new State(1, 1, STATE.TRIANGLE));
  states.get(0).set_params(new boolean[]{true}, new int[][]{{STATE.TRIANGLE,STATE.TRIANGLE}});
  states.get(0).ts_cumsum_min = 3000;
  
  states.add(new State(1, 3, STATE.CIRCLE));  
  states.get(1).set_params(new boolean[]{true}, new int[][]{{STATE.CIRCLE,STATE.CIRCLE}});
  states.get(1).ts_moment_psy_min = 3000;
  //states.get(1).DEBUG = true;
  
  states.add(new State(1, 2, STATE.RECT));  
  states.get(2).set_params(new boolean[]{true}, new int[][]{{STATE.RECT,STATE.RECT}});
  //states.get(2).DEBUG = true;
  
  states.add(new State(1, 4, STATETASK.FINAL_STATE));  
  states.get(3).set_params(new boolean[]{false}, new int[][]{{STATETASK.FINAL_STATE,STATETASK.FINAL_STATE}});
  //states.get(3).DEBUG = true;
  
  states.get(3).is_final = true;
  
  HashMap<Integer, Integer[]> trans = new HashMap<Integer, Integer[]>();
  trans.put(STATE.TRIANGLE, new Integer[]{STATE.CIRCLE});
  trans.put(STATE.CIRCLE,   new Integer[]{STATE.RECT});
  trans.put(STATE.RECT,     new Integer[]{STATETASK.FINAL_STATE});
  
  
  FTransitions ftrans = new FTransitions();
  State[] statesA = new State[states.size()];
  statesA = states.toArray(statesA);
  
  taskTRCE = new StateMachine(statesA, 0, trans, ftrans);
  taskTRCE.title = "TASKS";
  task_SM = taskTRCE;
}

PsyDyn task_metrics = new PsyDyn(0);

void taskUpdate(){
  task_SM.up(time);
  
  task_metrics.up_value(SM.cs().gid, 0);
  //for(int i = 0;i<task_metrics.params.length;i++){ println("i="+i+" : "+task_metrics.params[i].v); }
  //println(task_metrics.params[0].v);
  task_SM.up_psy(task_metrics);
  
  if (timer.on_timer(3,1000)){
    println(task_SM.print_status());
  }
}