class TimeTemp implements IUpd{
  int Mt; // Max time
  int t ; // time
  int mt; // Min time
  boolean active = false;
  void upd(int dms){
    if (active)
      t += dms;          
  }
  
  boolean ifExpired(){
    return (t>= Mt) && (t >= mt);
  }
  
  void activate(){
    active = true;
  }
  
}

class onBoardElem implements IDraw{
  String text;
  float maxtime;
  
  void draw(){
  }
}

class onBoard{
  ArrayList<onBoardElem> elems;
  PFont font;  
}