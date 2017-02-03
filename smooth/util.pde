float setVal(float p, float add, float def){
  float newVal = p+add;
  
  if (def<=0){
    if (newVal<def)
      return def;
    else return newVal;
  } else
  if (def>=100)
    if (newVal>=def)
      return def;
    else return newVal;
  
  return def;
}

class Smoother{
  float[] coefs = {0.05, 0.1, 0.15, 0.2, 0.2, 0.3};
  float[] v = new float[6];
  
  Smoother(){
    for(int i=0;i<v.length;i++){
      v[i] = 0;
    }
  }
  
  float add(float V){
    for(int i=1;i<v.length;i++){
      v[i-1] = v[i];
    }
    v[5] = V;
    return V;
  }
  
  float getV(){
    float r = 0;
    for(int i=0;i<v.length;i++){
      r += coefs[i]*v[i];
    }
    return r;
  }
  
  void printIt(){
    print("V:"+getV()+"\n");
  }
}