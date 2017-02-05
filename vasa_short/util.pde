// utils function

float toV(float from, float to, float add){
  float med = max(min(abs(to-from), add),0) * sign(to-from);
  return from + med;
}

float sign(float v){
  if (v == 0)
    return v;
  else
    return abs(v)/v;
}