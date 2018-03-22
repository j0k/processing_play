class TimeTemp implements IUpd, IReset{
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
  
  void reset(){
    t = 0;
    active = false;
  }
  
  TimeTemp(float mt, float Mt){
    this.Mt = (int) Mt * 1000;
    this.mt = (int) mt * 1000;
    this.t = 0;
  }
  
  TimeTemp(){
    this.Mt = 20 * 1000;
    this.mt = 1 * 1000;
    this.t = 0;
  }
}

class onBoardElem extends TimeTemp{
  String txt;
  
  Point2D p; // this choord
  Point2D obj; // to
  onBoard mng; // managing board
  onBoardElem(Point2D p, String txt, Point2D obj, onBoard mng){    
    super(1 , 15.5);
    this.p = p;
    this.txt = txt;
    this.obj  = obj;
    this.mng  = mng;    
  }
}



class onBoard implements IUpd, IReset{
  ArrayList<onBoardElem> elems;
  PFont font;
  
  int symbPerLine = 10; 
  int cur = 0;
  
  boolean active=true;
  
  Rect r;
  LerpFloatP perc = new LerpFloatP(0,0.03,1);
  
  onBoard(){
    // ;;
    elems = new ArrayList<onBoardElem>();     
  }
  
  
  void upd(int dms){
    if (active && ((elems != null) && (elems.size() > cur)))
    {
      onBoardElem e = elems.get(cur);
      e.upd(dms);
      
      if (e.ifExpired())
      {
        next();
      }
      
      if (e.obj != null)
        perc.upd(dms);
        
        
    }       
  }
  
  
  void init(){
    if ((elems != null) && (elems.size() > cur)){
      onBoardElem e = elems.get(cur);
      e.reset();
      e.active = true;
      
      Point2D p = (e.p != null) ? e.p : new Point2D(0,0); 
      r = rectTextT1(e.txt, p, symbPerLine);
      perc.reset();
    }
  }
  
  void draw(){
    if (!active)
    return;
    
    if ((elems != null) && (elems.size() > cur)){
      onBoardElem e = elems.get(cur);
      
      if (e.obj != null){        
        lineFromTo(r, e.obj, perc.v);
        //print(nf(perc, 3, 3) + " ");
      }
      
      fill(30,150);
      rect(r.x, r.y, r.w, r.h);
      fill(255);
      textAlign(CENTER, CENTER);
      text(e.txt, r.x, r.y, r.w, r.h);
    }          
  }
  
  void reset(){
     cur = 0;
     init();
  }
  
  void next(){
    if (cur == elems.size() -1){
      //active = false;
      reset();
      
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