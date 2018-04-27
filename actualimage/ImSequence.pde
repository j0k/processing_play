class Sequence implements IDraw{
  int n = 10;
  
  int active = 0;
  boolean finish = true;
  ArrayList<Imaginative> imgs = new ArrayList<Imaginative>(0);
  
  void add(Imaginative im){
    imgs.add(im);
  }
  
  void setup(){
    float x = width/2, dx = 20;
    float y = 0;
    
    for(int i = 0; i<imgs.size(); i++)
    {
      
      Imaginative im = imgs.get(i);
      if (i==0){
        x -= im.w/2;
       //im.x = w 
      }
      // im.
      im.x = x;
      x += im.w + dx;
      im.y = height/5;
    }
    
    imgs.get(active).active = true;
  }
  
  
  boolean isTrans=false;
  
  int goNext(){
    if (isTrans)
      return active;
          
      
    imgs.get(active).active = false;
    timer.reset();
    if (active < (imgs.size() - 1))
      { 
        active ++;
        isTrans = true;
        
        speed = 0;
        return active;        
      }
    else {
      finish = true;
      return -1;
    }
    
    
  }
  
  float speed = 0;
  void speedUp(){
    speed = lerp(speed,5,0.01);
  }
  
  void draw(){    
    if (isTrans){      
      for(int i = 0; i<imgs.size(); i++)
      {
        Imaginative im = imgs.get(i);
        im.x -= speed;
        speedUp();
        
        if (i == active){
          if (im.x < (width/2) - (im.w/2)){            
            im.active = true;
            isTrans = false;
          }
        }
      }
      //      ___
      // <[: - - - :]>
      //      ===
    } 
    else {
      

      
    }
    
    for(int i = 0; i<imgs.size(); i++)
      {
        Imaginative im = imgs.get(i);  
        if (inScreen(im))
          im.draw();
      }
  }
  
  
  void up(Timing time, PsyDyn metrics){
    Imaginative im = imgs.get(active);
    if (im.active){
      im.progress += (time.dt * im.VP * (0.5 + pow(im.scale(metrics)/50,2)) );
      im.progress = min(im.progress, 100);
      if (im.progress == 100){
        im.achieved = true;
        if (im.achieved && im.feedbacked){          
          goNext();
        }
      }
    }
    
  }
}