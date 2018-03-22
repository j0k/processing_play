interface IReset{
  void reset();
}

class FloatP implements IUpd, IReset{
  // ;; Float Param
  float v, v0, vt;

  FloatP(float v, float vt){
    this.v  = v;
    this.v0 = v;
    this.vt = vt;
  }
  
  void reset(){
    v = v0;
  }
  
  void upd(int dms){
   v += vt * dms;
  }
}

class LerpFloatP extends FloatP{
  float vD; // vDest
  LerpFloatP(float v, float vt, float vD){
    super(v,vt);
    this.vD = vD;   
  }
  
  void upd(int dms){
    v = lerp(v, vD, vt);
  }
}