// detalize paint
// smudge paint

MindState[] states = new MindState[3];
// MindState(String title, bool att_active, float attL, float attR, bool med_active, float medL, float medR ){
states[0] = new MindState("First" , false, 0, 0, true, 20, 100, 5, 20);
states[1] = new MindState("Second", false, 0, 0, true, 40, 100, 5, 20);
states[2] = new MindState("Third", false, 0, 0, true, 40, 100, 5, 20);

StateMachine SM = new StateMachine(states, 0);