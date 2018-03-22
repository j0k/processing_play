class TimeTemp implements IUpd{
  int Mt; // Max time
  int t = 0 ; // time
  int mt; // Min time
  boolean active = false;
  void upd(int dms){
    if (active)
      t += dms;          
  }
  
  boolean ifExpired(){
    return active && (t>= Mt) && (t >= mt);
  }
  
  void activate(){
    active = true;
  }
  
  TimeTemp(){
    Mt = 120 * 1000;
    mt = 1 * 1000;
  }
}

class onBoardElem implements IDraw{
  String txt;
  
  Point2D p; // this choord
  Point2D obj; // to
  onBoard mng; // managing board
  onBoardElem(Point2D p, String txt, Point2D obj, onBoard mng){    
    this.p = p;
    this.txt = txt;
    this.obj  = obj;
    this.mng  = mng;
  }
  void draw(){
    
  }
}



class onBoard{
  ArrayList<onBoardElem> elems;
  PFont font;
  
  int symbPerLine = 10; 
  int cur = 0;
  
  boolean active=true;
  
  Rect r;
  float perc = 0.3;
  onBoard(){
    // ;;
    elems = new ArrayList<onBoardElem>(); 
    
  }
  
  void init(){
    if ((elems != null) && (elems.size() > cur)){
      onBoardElem e = elems.get(cur);
      Point2D p = (e.p != null) ? e.p : new Point2D(0,0); 
      r = rectTextT1(e.txt, p, symbPerLine);
      perc = 0.0;
    }
  }
  
  void draw(){
    if (!active)
    return;
    
    if ((elems != null) && (elems.size() > cur)){
      onBoardElem e = elems.get(cur);
      
      if (e.obj != null){
        perc = lerp(perc, 1.0, 0.03);
        lineFromTo(r, e.obj, 1);
        //print(nf(perc, 3, 3) + " ");
      }
      
      fill(30,150);
      rect(r.x, r.y, r.w, r.h);
      fill(255);
      textAlign(CENTER, CENTER);
      text(e.txt, r.x, r.y, r.w, r.h);
    }          
  }
  
  void next(){
    if (cur == elems.size() -1){
      //active = false;
      cur = 0;
      
    } else {
      cur ++;      
    }
    init();
    
  }
  
  float lastTimeClick = 0;
  void checkMouse(){
    if (active && inside(mouseX, mouseY, r) && (millis() - lastTimeClick  > 200)){
      next();
      lastTimeClick = millis();
    }
  }
}

Rect rectTextT1(String txt, Point2D p, int spl){
  // symbols per line
  int splp = 5;
  Rect r = textBox(txt, 0, 0);
  int ns  = txt.length();
  
  int wps = (int) (r.w / ns) + 2; // width per symbol  
  int hpr = (int) (r.h);
  
  int rsc = ns / (spl + splp); // row symbol count
  
  int tw = (ns < spl) ? (ns + splp) * wps : (spl + splp ) * wps;
  
  //int tw = (spl + splp ) * wps; 
  int th = (rsc + 2) * (hpr);
  
  return new Rect(p.x, p.y, p.x + tw, p.y + th);

}