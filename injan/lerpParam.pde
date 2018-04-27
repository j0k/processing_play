class LerpParam implements IUp{
  float ve; // v exact
  float vl; // v lerp
  float lp; // lerp param
  
  LerpParam(float v, float lp){
    this.ve = v;
    this.lp = lp;
    this.ve = v;
  }
  
  void up(Timing t){
    vl = lerp(vl,ve,lp);
  }
}