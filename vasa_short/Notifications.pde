class ScreenNotification{
  ArrayList<String> notes = new ArrayList<String>();
  ArrayList<ActionTimer> timer = new ArrayList<ActionTimer>(); 
  
  void draw(){
    for(int i=0; i < notes.size(); i++){
      fill(timer.get(i).toCountOver(255));
      textSize(25 - timer.get(i).toCountOver(24));
      text(notes.get(i), width/2, 100 - (int) timer.get(i).toCountOver(80) ); 
    }
    
    int c = 0;
    int i = 0;
    int s = timer.size();
    while( c < s){
      if (timer.get(i).isOver()){
        timer.remove(i);
        notes.remove(i);
        c ++;
      } else{
        i++;
        c++;
      }
    }
  }
  
  void addText(String str){
    notes.add(str);
    timer.add(new ActionTimer(20,3000));
    
  }
}