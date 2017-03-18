ActionTimer pushParticle = new ActionTimer(20);

int pushPartN=0;
void pushParticles(){
  if (pushParticle.itsDurationEnough(millis())){
    
    pushPartN ++;
    pushPartN = pushPartN % particles.size();
    particle A = (particle) particles.get(pushPartN);
    A.v.x = 0;
    A.v.y = -2;
    A.x.y = 0;
    A.x.x = (width/2) - 40 + random(40);
  }
}