int[][] outLeftVaseBound = 
  {
    {81,98},
    {127,184},
    {77,242},
    {82,281},
    {142,333}
  }; // from top to bottom
  
int[][] outRightVaseBound =
  {
    {259,98},
    {213,184},
    {263,242},
    {258,281},
    {198,333}
  };
  
int[][] outBottomVaseBound = 
  {
    {142,333},
    {198,333}
  };

int[][] inLeftVaseBound; // from top to bottom
int[][] inRightVaseBound;
int[][] inBottomVaseBound;

public class RectBound{
   PVector[] p;
   float mag;
  
  RectBound(PVector p1, PVector p2, PVector p3, PVector p4){
    PVector[] p = {p1,p2,p3,p4};
    mag = dist(p1.x,p1.y,p3.x,p3.y);
    this.p = p;
  }
}

ArrayList<RectBound> bRects = new ArrayList<RectBound>();

void calcInVaseBoundLayer(){
  int th = 10; // thikness
  
  int s = outLeftVaseBound.length;
  inLeftVaseBound = new int[s][2];
  for(int i = 0; i < s; i++){
    inLeftVaseBound[i][0] = outLeftVaseBound[i][0] + th;
    inLeftVaseBound[i][1] = outLeftVaseBound[i][1];
  }
  
  s = outRightVaseBound.length;
  inRightVaseBound = new int[s][2];
  for(int i = 0; i < s; i++){
    inRightVaseBound[i][0] = outRightVaseBound[i][0] - th;
    inRightVaseBound[i][1] = outRightVaseBound[i][1];
  }
  
  s = outBottomVaseBound.length;
  inBottomVaseBound = new int[s][2];
  for(int i = 0; i < s; i++){
    inBottomVaseBound[i][0] = outBottomVaseBound[i][0];
    inBottomVaseBound[i][1] = outBottomVaseBound[i][1]-th;
  }
  
  vaseTopY = 1000;
  vaseBottomY = 0;
  
  for (int[] coord : outLeftVaseBound){
    vaseTopY = min(vaseTopY, coord[1]);
    vaseBottomY = max(vaseBottomY, coord[1]);
  }
  
    for (int[] coord : outBottomVaseBound){
    vaseTopY = min(vaseTopY, coord[1]);
    vaseBottomY = max(vaseBottomY, coord[1]);
  }
  
  vaseHeight = vaseBottomY - vaseTopY;
  
  println(vaseHeight);
}

void updateVaseBound(int[][] bounds,int addX, int addY){
  int s = bounds.length;
  
  for(int i = 0; i < s; i++){
    bounds[i][0] = bounds[i][0] + addX;
    bounds[i][1] = bounds[i][1] + addY;
  }
}

void updateVaseBounds(int addX, int addY){
  Object[] objs = {
   outLeftVaseBound, 
   outRightVaseBound,
   outBottomVaseBound,
   inLeftVaseBound,
   inRightVaseBound,
   inBottomVaseBound
 };
 
 for (Object o : objs){
   updateVaseBound((int[][]) o, addX,addY);
 }
}

int vaseHeight,vaseTopY,vaseBottomY;
void vaseBoundSetup(){
  calcInVaseBoundLayer();
  updateVaseBounds(10,200);
  calcInVaseBoundLayer();
}

void drawDoubleMat(int a[][]){
  int s = a.length;
  if (s>=2){
    for (int i = 1; i < s; i++ ){
      PVector pre = toPVector (a[i-1]);
      PVector last = toPVector (a[i]);
      line(pre.x,pre.y,last.x,last.y);
    }
  }
}

float levelVase = 0.005;
float levelVaseStep = 0.005;

ActionTimer boundT = new ActionTimer(1);

int levelDir = 1;
void drawAllBounds(){

  if (!stopAll){ 
    if (boundT.itsDurationEnough(millis())){
      
      //levelVase +=  levelVaseStep * levelDir;
    }
    
    
    if(levelVase>1){
      //levelVase = 1 - levelVaseStep;
      //levelDir = -levelDir;
    } else if (levelVase<0){
      //levelVase = 0 + levelVaseStep;
      //levelDir = -levelDir;
    } 
  }
    
  //Object[] todraw = {outLeftVaseBound}
  //println("1\n");
  //drawDoubleMat(outLeftVaseBound);
  // println("2\n");
  //drawDoubleMat(outRightVaseBound);
  //println("3\n");
  //drawDoubleMat(outBottomVaseBound);
  //println("4\n");
  //drawDoubleMat(inLeftVaseBound);
  //println("5\n");
  //drawDoubleMat(inRightVaseBound);
  
  //drawDoubleMat(inBottomVaseBound);
  
  bRects.clear();
  fillTheDoubleMat(levelVase,outLeftVaseBound,inLeftVaseBound,vaseTopY,vaseBottomY);
  fillTheDoubleMat(levelVase,outRightVaseBound,inRightVaseBound,vaseTopY,vaseBottomY);
  fillTheDoubleMat(levelVase,outBottomVaseBound,inBottomVaseBound,vaseTopY,vaseBottomY);
}




void fillTheDoubleMat(float p, int[][] a, int[][] b, int topY, int botY){
  // p - percent 0 .. 1
  int hd = (int) (p * vaseHeight); //height to draw
  int topHD = botY - hd;
  // we need to draw botY .. topHD
  
  int s = a.length;
  if (s>=2){
    for (int i = 1; i < s; i++ ){
      PVector preA = toPVector (a[i-1]);
      PVector lastA = toPVector (a[i]);
      
      PVector preB = toPVector (b[i-1]);
      PVector lastB = toPVector (b[i]);
      fill(color(70,70,200));
      if ( lastA.y >= topHD ){
        // we have to draw part of it
        if (preA.y >= topHD ){
          // we need to draw it full
            
            drawQuad(preA,lastA,lastB,preB);
            bRects.add(new RectBound(preA,lastA,lastB,preB));
        } else {
          PVector va = takeXYBetween(preA,lastA,topHD);
          PVector vb = takeXYBetween(preB,lastB,topHD);
          drawQuad(va,lastA,lastB,vb);
          bRects.add(new RectBound(va,lastA,lastB,vb));
        }
      }
      
    }
  }
  fill(0);
}

PVector takeXYBetween(PVector pre, PVector last, int topHD){
  int x1 = (int) pre.x;
  int y1 = (int) pre.y;
  
  int x2 = (int) last.x;
  int y2 = (int) last.y;
  
  float p = (float)(y2 - topHD)/(y2 - y1); // 0..1
  //println(p);
  float xres = x2 - (float) p*(x2 - x1);
  
  return new PVector(xres, topHD);
}

void drawQuad(PVector a1, PVector a2, PVector a3, PVector a4){
  quad(a1.x,a1.y,a2.x,a2.y,a3.x,a3.y,a4.x,a4.y);
}

class Distance{
  float amp;
  PVector di;//rection
}

float calcDistance(PVector p, RectBound b){
  return 0;
}