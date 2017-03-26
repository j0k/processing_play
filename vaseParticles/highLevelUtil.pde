ActionTimer pushParticle = new ActionTimer(1000);

int pushPartN=0;
void pushParticles(){
  if (pushParticle.itsDurationEnough(millis())){
    int c = 0;
    pushPartN ++;
    pushPartN = pushPartN % particles.size();
    while ((calcParts.partVC[pushPartN] == 1) && ( c < particles.size() )){
      pushPartN ++;
      pushPartN = pushPartN % particles.size();
      c ++;
    }
    
    if (c < particles.size()){
      particle A = (particle) particles.get(pushPartN);
      A.v.x = 0;
      A.v.y = 2;
      A.x.y = topPhys;
      A.x.x = (width/2) - 40 + random(40);
    } 
    
  }
}