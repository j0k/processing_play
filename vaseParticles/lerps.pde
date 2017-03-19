float lerpCent(float vStart, float vFin, float pos, float center){
  // vFin achieved in center
  // center in [0,1]
  // pos in [0,1]
  
  float vcenter = lerp(vStart,vFin,center);
  if (vStart <= vFin){
    
    if (pos < center){
      return map(pos,0,center,vStart,vFin);  
    } else {
      return map(pos-center,0,1-center,vFin,vStart);
    }
  } else {
    if (pos > center){
      return map(pos-center,1-center,0,vStart,vFin);
    } else {
      return map(pos,center,0,vFin,vStart);
    }
  }
}

float lerpBounds(float vStart, float vFin, float posIn, float center, float left, float right){
  // vFin achieved in center
  // center,left,right in [0,1]
  // pos in [0,1]
  float pos = map(posIn,0,1,left,right);
  
  return lerpCent(vStart,vFin,pos,center);
}