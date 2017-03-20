class Circle{
  int x,y,rad;
  
  Circle(int x, int y, int rad){
    this.x = x;
    this.y = y;
    this.rad = rad;
  }
}

class CalcParts{
  boolean[] partC; // particleCalced
  int[] partVC;

  ArrayList<Circle> calcAreas; 
  
  
  void clear(){
    for(int i = 0; i < nParts; i++){
      partC[i]  = false;
      partVC[i] = 0;
    }
  }
  
  CalcParts(){
    this.initParticleCalculation();
  }
  
  void initParticleCalculation(){
    partC = new boolean[nParts];
    partVC = new int[nParts];
    calcAreas = new ArrayList<Circle>();
    
    clear();
  }
  
  int calcIn(int x, int y, int rad, ArrayList<particle> ps){
    int n = 0;
    for(int i=0;i<ps.size();i++){
      if ((abs(ps.get(i).x.x - x) <= rad) && (abs(y - ps.get(i).x.y) <= rad)){
        n++;
        if (!partC[i]){
          partC[i] = true;
          partVC[i] = 1;
        }
      }
    }
    return n;
  }
  
  int calcIn(Circle area,ArrayList<particle> ps){
    return calcIn(area.x, area.y, area.rad, ps);
  }
  
  int calculated = 0;
  int calcInAllAreas(ArrayList<particle> ps){
    int n=0;
    clear();
    
    for( Circle area : calcAreas){
      calcIn(area, ps);
    }
    
    for(int v: partVC){
      n += v;
    }
    
    this.calculated = n;
    return n;
  }
  
  void draw(){
    for( Circle area : calcAreas){
      int x = area.x;
      int y = area.y;
      int r = area.rad/2;
      
      fill(color(random(100,255),random(100,255),random(100,255)));
      ellipse(x, y, area.rad, area.rad);
    }
  }

  void addArea(Circle area){
     calcAreas.add(area);
  }
};

CalcParts calcParts;

void initPartsCalculation(){
  calcParts = new CalcParts();
  calcParts.addArea(new Circle(180, 456,150));
  calcParts.addArea(new Circle(180, 370,90));
  calcParts.addArea(new Circle(180, 310,130));
}

void updateCalcs(){
  calcParts.draw();
  
  calcParts.calcInAllAreas(particles);
  println(calcParts.calculated);
}