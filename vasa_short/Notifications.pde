class ScreenNotification{
  ArrayList<Note> notes = new ArrayList<Note>();

  ArrayList<ActionTimer> timer = new ArrayList<ActionTimer>();

  void draw(){
    for(int i=0; i < notes.size(); i++){
      fill(timer.get(i).toCountOver(255));
      textSize(25 - timer.get(i).toCountOver(24));
      if (notes.get(i).t == 0)
        text(notes.get(i).msg, notes.get(i).x, 100 - (int) timer.get(i).toCountOver(80) );
      else if (notes.get(i).t == 1)
        text(notes.get(i).msg, notes.get(i).x, 100 + (int) timer.get(i).toCountOver(80) );
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
    addText(str,width/2,0);
  }

  void addText(String str, int x){
    addText(str,x,0);
  }

  void addText(String str, int x, int t){
    notes.add(new Note(str,x,t));
    timer.add(new ActionTimer(20,3000));
  }
}

class Note{
  String msg;
  int x;
  int t=0;

  Note(String m, int x){
      this.msg = m;
      this.x = x;
  }

  Note(String m, int x, int t){
      this.msg = m;
      this.x = x;
      this.t = t;
  }
}
