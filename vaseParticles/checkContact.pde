// contact checking is based on https://www.openprocessing.org/sketch/168319 
// and this https://forum.processing.org/two/discussion/15700/orthogonal-projection-of-a-point-onto-a-line
float nearC = 10;

PVector center(RectBound b){
  float x = 0;
  for( int i = 0; i<b.p.length;i++)
    x += b.p[i].x;
  x /= 4;
  
  float y = 0;
  for( int i = 0; i<b.p.length;i++)
    y += b.p[i].y;
  y /= 4;
  
  return new PVector(x,y);
}

PVector avgPoint(PVector p1, PVector p2){
  return new PVector((p1.x + p2.x)/2, (p1.y + p2.y)/2 );
}

boolean inRound(PVector center, float radius, float near, PVector p){
  float x = center.x - p.x;
  float y = center.y - p.y;
  
  if ((0.5 * sqrt(sq(x) + sq(y))) < (radius + near))
    return true;
  else
    return false;
}

PVector Projection(PVector line_p1, PVector line_p2, PVector p){
  float y1 = line_p1.y;
  float y2 = line_p2.y;
  float x1 = line_p1.x;
  float x2 = line_p2.x;
  
  if ((x1 == x2) && (y1 == y2))
    return new PVector(x1,y1);
    
  float k = ((y2-y1) * (p.x-x1) - (x2-x1) * (p.y-y1)) / (sq(y2-y1) + sq(x2-x1));
  float x4 = p.x - k * (y2-y1);
  float y4 = p.y + k * (x2-x1);
  
  return new PVector(x4,y4);
}

boolean inside(PVector line_p1, PVector line_p2, PVector proj, float near){
  boolean x_res = false;
  boolean y_res = false;
  if ((near + line_p1.x >= proj.x) && (proj.x >= line_p2.x - near)){
    x_res = true;
  }
  
  if ((line_p1.x - near <= proj.x) && (proj.x <= line_p2.x + near)){
    x_res = true;
  }
  
  if ((line_p1.y + near >= proj.y) && (proj.y >= line_p2.y - near)){
    y_res = true;
  }
  
  if ((line_p1.y - near <= proj.y) && (proj.y <= line_p2.y + near)){
    y_res = true;
  }
  
  return (x_res && y_res);
}


float thick(PVector p1, PVector p2){ 
  return sqrt(sq(p1.y-p2.y) + sq(p1.x-p2.x))/2;
}

boolean detectContact1(PVector p, RectBound b, float near)
{
  return inRound(center(b), b.mag, 0, p);
}

// Class function detectContact2
// Detects if the shapes of the bots are in contact.
// Checks if the corners of bot1 are within bot2, and then the opposite
float dist(PVector p1, PVector p2){
  return dist(p1.x,p1.y,p2.x,p2.y);
}


PVector detectContact2(particle A, RectBound b, float near)
{
  PVector p = A.x;
  PVector avgP1 = avgPoint(b.p[1], b.p[2]); 
  PVector avgP2 = avgPoint(b.p[3], b.p[0]);
  
  PVector avgP3 = avgPoint(b.p[0], b.p[1]); 
  PVector avgP4 = avgPoint(b.p[2], b.p[3]);
  
  PVector proj1 = Projection(avgP1,avgP2,p);
  PVector proj2 = Projection(avgP3,avgP4,p);
  
  float d1 = dist(proj1,p);
  float th_d1 = thick(avgP3,avgP4);
    
  float d2 = dist(proj2,p);
  float th_d2 = thick(avgP1,avgP2);
  
  float dBottom = dist(avgP1,p);
  float dTop = dist(avgP2,p);
  
  float dRight = dist(avgP4,p);
  float dLeft = dist(avgP3,p);
  
  float dBT = min(dBottom,dTop); 
  float dRL = min(dRight,dLeft);
  
  if(inside(avgP1, avgP2, proj1, nearC)){
    if (d1 < (th_d1 + near))
    {
      // contact!
      proj1.sub(p);
      proj1.mult(-1);
      proj1.normalize();
      return proj1;
      //use d1
      // contact!
    }
  } else {
    if(inside(avgP3, avgP4, proj2, nearC)){
       if (d2 < (th_d2 + near))
      {
        // contact!
        proj2.sub(p);
        proj2.mult(-1);
        proj2.normalize();
        return proj2;
      }
    }
  }
  
  return new PVector(0,0);
  
}

boolean checkContact(particle p){
  boolean res = false;
  
  for( RectBound b : bRects){
    if (detectContact1(p.x, b, nearC))
    {
      PVector orth = detectContact2(p,b,nearC);
      if (orth.mag() > 0){
        p.v.y = orth.y/1;
        p.v.x = orth.x/1;
        p.f.y = orth.y/10;
        p.f.x = orth.x/10;
        res = true;
      }
    }
    
  }
  return res;
}